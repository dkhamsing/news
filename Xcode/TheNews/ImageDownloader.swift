//
//  ImageDownloader.swift
//  TheNews
//
//  Created by Daniel on 4/12/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class ImageDownloader {
    var imageCache: [String: UIImage] = [:]

    func getImage(imageUrl: String?, size: CGSize, completion: @escaping (UIImage?) -> Void) {
        guard
            let str = imageUrl,
            let url = URL.init(string: str)
        else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }

        let k = key(urlString: url.absoluteString, size: size)

        if let cached = imageCache.cached(k) {
            DispatchQueue.main.async {
                completion(cached)
            }
            return
        }

        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
            }

            let resized = image.resized(size: size)

            DispatchQueue.main.async { [weak self] in
                self?.imageCache.cache(key: k, value: resized)
                completion(resized)
            }
        }
    }
}

private extension ImageDownloader {
    func key(urlString: String, size: CGSize) -> String {
        let s = "\(urlString)-\(size.width)-\(size.height)"
        return s
    }
}

private extension Dictionary where Key == String {
    func cached(_ key: String) -> UIImage? {
        return self[key] as? UIImage
    }

    mutating func cache(key: String, value: Value?) {
        self[key] = value
    }
}

private extension UIImage {
    func resized(size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = self
        return renderer.image { (context) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
