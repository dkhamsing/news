//
//  Created by Daniel on 12/13/20.
//

import UIKit

class RedditCell: NewsCell {

    static let identifier: String = "RedditCell"
    static var logoSize = CGSize(width: 35, height: 35)

    private static let imageWidth: CGFloat = 100
    private static let imageHeight: CGFloat = 70

    override func config() {
        super.config()

        title.font = .preferredFont(forTextStyle: .headline)

        articleImageView.layer.cornerRadius = 6
        articleImageView.layer.masksToBounds = true

        summary.font = .preferredFont(forTextStyle: .subheadline)

        source.numberOfLines = 2

        logo.layer.cornerRadius = RedditCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        [logo, source, title, articleImageView, summary].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: RedditCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: RedditCell.logoSize.width),

            source.topAnchor.constraint(equalTo: logo.topAnchor, constant: -1),
            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10),

            title.leadingAnchor.constraint(equalTo: logo.leadingAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 15),
            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 8),
            title.centerYAnchor.constraint(equalTo: articleImageView.centerYAnchor),

            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.widthAnchor.constraint(equalToConstant: RedditCell.imageWidth),
            articleImageView.heightAnchor.constraint(equalToConstant: RedditCell.imageHeight),
            articleImageView.bottomAnchor.constraint(equalTo: summary.topAnchor, constant: -5),

            summary.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor),
            summary.topAnchor.constraint(equalTo: title.bottomAnchor),

            contentView.bottomAnchor.constraint(equalTo: summary.bottomAnchor, constant: 15)
        ])
    }

    func load(article: Article, downloader: ImageDownloader) {
        title.text = article.titleDisplay
        source.attributedText = article.redditAttributed
        summary.text = article.descriptionOrContent

        let size = CGSize(width: RedditCell.imageWidth, height: RedditCell.imageHeight)
        load(urlString: article.urlToImage, downloader: downloader, size: size)

        loadLogo(urlString: article.urlToSourceLogo, size: RedditCell.logoSize, downloader: downloader)
    }

}

private extension Article {

    var redditAttributed: NSAttributedString {
        guard let name = source?.name else { return NSAttributedString() }

        let fontSize: CGFloat = 14

        let aAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: UIColor.systemGray
        ]
        let a = NSMutableAttributedString(string: "r/", attributes: aAttribute)

        let bAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: fontSize),
            .foregroundColor: UIColor.gray
        ]
        let b = NSAttributedString(string: "news\n", attributes: bAttribute)
        a.append(b)

        let user = "u/\(name)".replacingOccurrences(of: " ", with: "")
        var str = user

        if let ago = ago {
            str = str + " · \(ago)"
        }

        let c = NSAttributedString(string: str, attributes: aAttribute)
        a.append(c)

        return a
    }

}
