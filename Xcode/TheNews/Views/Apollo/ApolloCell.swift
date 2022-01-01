//
//  Created by Daniel on 12/18/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class ApolloCell: NewsCell {

    static let identifier: String = "ApolloCell"

    let url = UILabel()

    override func config() {
        super.config()

        source.font = .boldSystemFont(ofSize: 15)

        ago.textColor = .secondaryLabel
        ago.font = .preferredFont(forTextStyle: .caption1)

        url.textColor = .secondaryLabel
        url.font = .preferredFont(forTextStyle: .subheadline)

        [title, articleImageView, source, ago].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 240
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            articleImageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: inset),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            source.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset),
            source.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),

            ago.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 7),
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),

            contentView.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset)
        ])

        let banner = UIView()
        banner.backgroundColor = .systemGray5
        articleImageView.addSubviewForAutoLayout(banner)

        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            banner.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor),
            banner.heightAnchor.constraint(equalToConstant: 45)
        ])

        banner.addSubviewForAutoLayout(url)

        NSLayoutConstraint.activate([
            url.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: 10),
            url.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: -10),
            url.centerYAnchor.constraint(equalTo: banner.centerYAnchor)
        ])
    }

    func load(article: Article) {
        title.text = article.titleDisplay
        source.text = article.source?.name
        ago.text = article.ago
        url.text = article.urlDisplay
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
    }

}
