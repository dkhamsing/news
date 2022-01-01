//
//  Created by Daniel on 12/19/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class AppleNewsCellLarge: NewsCell {

    static let identifier: String = "AppleNewsCellLarge"

    private static let logoSize = CGSize(width: 24, height: 24)

    override func config() {
        super.config()

        articleImageView.layer.cornerRadius = 6
        articleImageView.layer.masksToBounds = true

        source.font = .boldSystemFont(ofSize: 12)

        let fontSize: CGFloat = 26
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        if let descriptor = systemFont.fontDescriptor.withDesign(.default) {
            title.font = UIFont(descriptor: descriptor, size: fontSize)
        }

        ago.font = .boldSystemFont(ofSize: 12)
        ago.textColor = .secondaryLabel

        [articleImageView, logo, source, title, ago].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 250
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            logo.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: AppleNewsCellLarge.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: AppleNewsCellLarge.logoSize.width),

            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 5),
            source.centerYAnchor.constraint(equalTo: logo.centerYAnchor),

            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            ago.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),

            contentView.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset)
        ])

    }

    func load(article: Article) {
        title.text = article.titleDisplay
        source.text = article.source?.name
        ago.text = article.ago
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: AppleNewsCellLarge.logoSize)
    }

}
