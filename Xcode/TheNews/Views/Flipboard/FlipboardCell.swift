//
//  Created by Daniel on 12/13/20.
//

import UIKit

class FlipboardCell: NewsCell {

    static let identifier: String = "FlipboardCell"
    private static let logoSize = CGSize(width: 38, height: 38)

    override func config() {
        super.config()

        source.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)

        ago.textColor = .systemGray
        ago.font = .systemFont(ofSize: 14)

        title.font = UIFont(name: "TimesNewRomanPSMT", size: 28)

        logo.backgroundColor = .secondarySystemBackground
        logo.layer.cornerRadius = FlipboardCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        [logo, ago, summary, source, title, articleImageView].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }

        let imageHeight: CGFloat = 240
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            title.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 18),
            title.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),

            summary.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            summary.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor),
            summary.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),

            logo.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 20),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: FlipboardCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: FlipboardCell.logoSize.width),

            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10),
            source.centerYAnchor.constraint(equalTo: logo.centerYAnchor),

            ago.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 22),
            ago.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor),

            contentView.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: 30)
        ])

    }

    func load(article: Article, downloader: ImageDownloader) {
        title.text = article.titleDisplay
        summary.attributedText = article.flipboardAttributedSubtitle
        source.text = article.source?.name
        ago.text = article.ago
        load(urlString: article.urlToImage, downloader: downloader)
        loadLogo(urlString: article.urlToSourceLogo, size: FlipboardCell.logoSize, downloader: downloader)
    }

}

private extension Article {

    var flipboardAttributedSubtitle: NSAttributedString {
        guard let font = UIFont(name: "AppleSDGothicNeo-Light", size: 15),
              let d = descriptionOrContent else { return NSAttributedString() }

        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.2

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: style
        ]

        return NSAttributedString(string: d, attributes: attributes)
    }

}
