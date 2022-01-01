//
//  Created by Daniel on 12/15/20.
//

import UIKit

class WashingtonPostCell: NewsCell {

    static let identifier: String = "WashingtonPostCell"

    override func config() {
        super.config()

        title.font = UIFont(name: "Georgia", size: 20)

        summary.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 16)

        source.textColor = .secondaryLabel
        source.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 14)

        [title, summary, articleImageView, source].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 230
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: inset),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            title.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),

            summary.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            summary.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor, constant: inset),

            source.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 5),
            source.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: inset),

            contentView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: inset)
        ])
    }

    func load(article: Article, downloader: ImageDownloader) {
        title.text = article.titleDisplay
        summary.text = article.description
        source.text = article.bottom
        load(urlString: article.urlToImage, downloader: downloader, debugString: title.text)
    }

}

private extension Article {
    var bottom: String? {
        var str = ""

        if let author = author, author.count > 0 {
            str = "By \(author) • "
        }

        if let ago = ago {
            str = "\(str)\(ago)"
        }

        return str
    }
}
