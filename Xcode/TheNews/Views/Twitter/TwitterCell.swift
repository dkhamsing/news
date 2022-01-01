//
//  Created by Daniel on 12/13/20.
//

import UIKit

class TwitterCell: NewsCell {

    static let identifier: String = "TwitterCell"
    private static let logoSize = CGSize(width: 50, height: 50)

    override func config() {
        super.config()

        logo.backgroundColor = .secondarySystemBackground
        logo.layer.cornerRadius = TwitterCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        source.font = .preferredFont(forTextStyle: .headline)
        ago.textColor = .secondaryLabel

        let topView = UIView()

        [topView, articleImageView, title].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }

        let rightView = UIView()

        [logo, rightView].forEach { item in
            topView.addSubviewForAutoLayout(item)
        }

        [source, ago].forEach { item in
            rightView.addSubviewForAutoLayout(item)
        }

        let imageHeight: CGFloat = 200
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            topView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: TwitterCell.logoSize.height),

            title.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            articleImageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            contentView.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            logo.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: TwitterCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: TwitterCell.logoSize.width),
            logo.centerYAnchor.constraint(equalTo: topView.centerYAnchor),

            rightView.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 5),
            rightView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            rightView.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            source.topAnchor.constraint(equalTo: rightView.topAnchor),
            source.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            source.trailingAnchor.constraint(equalTo: rightView.trailingAnchor),

            ago.topAnchor.constraint(equalTo: source.bottomAnchor),
            ago.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            ago.trailingAnchor.constraint(equalTo: rightView.trailingAnchor),
            ago.bottomAnchor.constraint(equalTo: rightView.bottomAnchor)
        ])
    }

    func load(article: Article, downloader: ImageDownloader) {
        title.text = article.titleDisplay
        source.text = article.source?.name
        ago.text = article.ago

        load(urlString: article.urlToImage, downloader: downloader)

        loadLogo(urlString: article.urlToSourceLogo, size: TwitterCell.logoSize, downloader: downloader)
    }

}
