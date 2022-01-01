//
//  Created by Daniel on 12/12/20.
//

import UIKit

class NewsCell: UITableViewCell {

    var articleImageView = UIImageView()
    var logo = UIImageView()

    var ago = UILabel()
    var source = UILabel()
    var summary = UILabel()
    var title = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        config()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
        logo.image = nil
    }

    func config() {
        self.selectionStyle = .none

        summary.numberOfLines = 0

        title.numberOfLines = 0

        articleImageView.backgroundColor = .secondarySystemBackground
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
    }

    func load(urlString: String?,
              downloader: ImageDownloader,
              size: CGSize? = nil,
              debugString: String? = nil,
              completion: (() -> Void)? = nil) {
        articleImageView.load(urlString: urlString, size: size, downloader: downloader) {
            completion?()
        }

        guard let string = urlString,
              let _ = URL(string: string) else {

            var message = "error for image url: \(urlString ?? "")"

            if let debug = debugString {
                message += " (" + debug + ")"
            }

            print(message)

            return
        }
    }

    func loadLogo(urlString: String?,
                  size: CGSize,
                  downloader: ImageDownloader = ImageDownloader.shared) {
        self.logo.load(urlString: urlString, size: size, downloader: downloader)

        guard let string = urlString,
              let _ = URL(string: string) else {
            print("error for image url: \(urlString ?? "")")
            return
        }
    }

}
