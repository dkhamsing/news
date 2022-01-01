//
//  Created by Daniel on 12/19/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class AppleNewsCell: NewsCell {

    static let identifier: String = "AppleNewsCell"

    private static let logoSize = CGSize(width: 20, height: 20)

    override func config() {
        super.config()

        articleImageView.layer.cornerRadius = 6
        articleImageView.layer.masksToBounds = true

        source.font = .boldSystemFont(ofSize: 12)

        title.numberOfLines = 4

        let fontSize: CGFloat = 15
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        if let descriptor = systemFont.fontDescriptor.withDesign(.default) {
            title.font = UIFont(descriptor: descriptor, size: fontSize)
        }

        ago.font = .boldSystemFont(ofSize: 12)
        ago.textColor = .secondaryLabel

        [articleImageView, logo, source, title, ago].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 120
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            articleImageView.widthAnchor.constraint(equalToConstant: imageHeight),

            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: AppleNewsCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: AppleNewsCell.logoSize.width),

            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 4),
            source.centerYAnchor.constraint(equalTo: logo.centerYAnchor),

            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 2),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),

            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: ago.bottomAnchor),

            contentView.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset)
        ])

    }

    func load(article: Article) {
        title.text = article.titleDisplay
        source.text = article.source?.name
        ago.text = article.ago
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: AppleNewsCell.logoSize)
    }

}
