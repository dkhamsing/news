//
//  Created by Daniel on 12/12/20.
//

import UIKit

class ImageDownloader {

    static let shared = ImageDownloader()

    private var imageCache = NSCache<AnyObject, UIImage>()
    private let debug = false

    func load(url: URL,
              size: CGSize? = nil,
              tag: Int,
              completion: @escaping (UIImage?, Int) -> Void) {
        let urlString = url.absoluteString
        let key = ImageDownloader.key(urlString: urlString, size: size)

        if let cacheImage = imageCache.object(forKey: key) {
            completion(cacheImage, tag)
            if debug {
                print("cache hit for key \(key)")
            }
            return
        }

        loadUrl(url: url, key: key, size: size, tag: tag) { (image, tag) in
            DispatchQueue.main.async {
                completion(image, tag)
            }
        }
    }

}

private extension ImageDownloader {

    static func key(urlString: String, size: CGSize?) -> AnyObject {
        var key = urlString

        if let size = size {
            key = key + "\(size.width)-\(size.height)"
        }

        return key as AnyObject
    }

    func loadUrl(url: URL,
                 key: AnyObject,
                 size: CGSize? = nil,
                 tag: Int,
                 completion: @escaping (UIImage?, Int) -> Void) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  var image = UIImage(data: data) else {
                completion(nil, tag)
                return
            }

            if let size = size {
                let newSize = image.size.aspectRatioForWidth(size.width)
                if let resized = image.resized(size: newSize) {
                    image = resized
                }
            } else {
                let screenWidth: CGFloat = UIScreen.main.bounds.width
                let newSize = image.size.aspectRatioForWidth(screenWidth)
                if let resized = image.resized(size: newSize) {
                    image = resized
                }
            }

            self?.imageCache.setObject(image, forKey: key)
            completion(image, tag)
        }
    }

}

private extension CGSize {

    func aspectRatioForWidth(_ width: CGFloat) -> CGSize {
        return CGSize(width: width, height: width * self.height / self.width)
    }

}

private extension UIImage {

    func resized(size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = self

        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }

}

extension UIImageView {

    func load(urlString: String?,
              size: CGSize? = nil,
              downloader: ImageDownloader,
              completion: (() -> Void)? = nil) {
        guard let string = urlString,
              let url = URL(string: string) else {
            completion?()
            return
        }

        let tag = Int.random(in: 1..<1000)

        self.tag = tag

        downloader.load(url: url, size: size, tag: tag) { [weak self] (downloaded, downloadTag) in
            guard self?.tag == downloadTag else { return }

            self?.image = downloaded
            completion?()
        }
    }

}
