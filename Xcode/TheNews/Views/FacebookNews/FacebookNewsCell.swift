//
//  Created by Daniel on 12/23/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class FacebookNewsCell: NewsCell {

    static let identifier: String = "FacebookNewsCell"
    private static let logoSize = CGSize(width: 20, height: 20)

    override func config() {
        super.config()

        articleImageView.layer.cornerRadius = 8
        articleImageView.layer.masksToBounds = true

        title.font = .preferredFont(forTextStyle: .title3)

        source.textColor = .secondaryLabel
        source.font = .preferredFont(forTextStyle: .caption1)

        logo.backgroundColor = .secondarySystemBackground
        logo.layer.cornerRadius = FacebookNewsCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        [articleImageView, logo, source, title].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }

        let imageHeight: CGFloat = 200
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            logo.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 16),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: FacebookNewsCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: FacebookNewsCell.logoSize.width),

            source.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 8),

            title.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            contentView.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: inset)
        ])
    }

    func load(article: Article) {
        title.text = article.titleDisplay
        source.text = article.fbSourceAgo
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: FacebookNewsCell.logoSize)
    }

}

private extension Article {

    var fbSourceAgo: String {
        var strings: [String] = []

        if let source = source?.name {
            strings.append(source)
        }

        if let ago = ago {
            strings.append(ago)
        }

        return strings.joined(separator: " · ")
    }

}
