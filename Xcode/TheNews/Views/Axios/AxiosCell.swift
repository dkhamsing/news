//
//  Created by Daniel on 12/20/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class AxiosCell: NewsCell {

    static let identifier: String = "AxiosCell"
    private static let logoSize = CGSize(width: 40, height: 40)

    let author = UILabel()

    override func config() {
        super.config()

        logo.layer.cornerRadius = AxiosCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        title.font = .preferredFont(forTextStyle: .title1)

        author.font = .preferredFont(forTextStyle: .subheadline)

        ago.textColor = .secondaryLabel
        ago.font = .preferredFont(forTextStyle: .subheadline)

        [logo, title, author, ago, articleImageView, summary].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 200
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.heightAnchor.constraint(equalToConstant: AxiosCell.logoSize.height),
            logo.heightAnchor.constraint(equalToConstant: AxiosCell.logoSize.width),

            author.topAnchor.constraint(equalTo: logo.topAnchor, constant: 2),
            author.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: 50),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: author.trailingAnchor),

            ago.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 2),
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: 50),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: ago.trailingAnchor),

            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: inset + 10),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            articleImageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: inset + 10),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            summary.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset + 6),
            summary.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor),

            contentView.bottomAnchor.constraint(equalTo: summary.bottomAnchor, constant: inset)
        ])

    }

    func load(article: Article) {
        title.text = article.titleDisplay
        summary.attributedText = article.attributedSummary
        author.text = article.author
        ago.text = article.agoSource
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: AxiosCell.logoSize)
    }

}

private extension Article {

    var agoSource: String {
        var strings: [String] = []
        if let ago = ago {
            strings.append(ago)
        }
        if let source = source?.name {
            strings.append(source)
        }
        return strings.joined(separator: " - ")
    }

    var attributedSummary: NSAttributedString {
        guard let font = UIFont(name: "Georgia", size: 20),
              let desc = descriptionOrContent else { return NSAttributedString() }

        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.4

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: style
        ]

        return NSAttributedString(string: desc, attributes: attributes)
    }
}
