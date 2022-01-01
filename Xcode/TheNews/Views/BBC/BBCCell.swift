//
//  Created by Daniel on 12/12/20.
//

import UIKit

class BBCCell: NewsCell {

    static let identifier: String = "BBCCell"

    private static let imageWidth: CGFloat = 140
    private static let imageHeight: CGFloat = 85

    private var main = UIView()
    private var badge = UILabel()

    override func config() {
        super.config()

        title.numberOfLines = 3
        title.font = .boldSystemFont(ofSize: 15)

        badge.backgroundColor = .systemGray
        badge.textColor = .white
        badge.font = .boldSystemFont(ofSize: 14)
        badge.textAlignment = .center

        ago.textColor = .secondaryLabel
        ago.font = .systemFont(ofSize: 15)

        main = UIView()
        contentView.addSubviewForAutoLayout(main)

        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            main.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            main.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            main.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            main.trailingAnchor.constraint(equalTo: contentView.readableContentGuide.trailingAnchor)
        ])

        [articleImageView, title, ago].forEach {
            main.addSubviewForAutoLayout($0)
        }

        NSLayoutConstraint.activate([
            articleImageView.centerYAnchor.constraint(equalTo: main.centerYAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: main.leadingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: BBCCell.imageHeight),
            articleImageView.widthAnchor.constraint(equalToConstant: BBCCell.imageWidth),

            title.topAnchor.constraint(equalTo: articleImageView.topAnchor, constant: 3),
            title.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: inset),
            main.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            ago.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: inset),
            main.trailingAnchor.constraint(equalTo: ago.trailingAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: 3),

            main.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset)
        ])

        articleImageView.addSubviewForAutoLayout(badge)

        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            badge.widthAnchor.constraint(equalToConstant: 30),
            badge.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func load(article: Article,
              row: Int,
              downloader: ImageDownloader = ImageDownloader.shared) {
        title.text = article.titleDisplay
        ago.text = article.agoSource

        let size = CGSize(width: BBCCell.imageWidth, height: BBCCell.imageHeight)
        load(urlString: article.urlToImage, downloader: downloader, size: size)

        badge.text = String(row + 1)
    }

}

private extension Article {

    var agoSource: String {
        var bottom = ago ?? ""
        if let source = source?.name {
            bottom += " | " + source
        }
        return bottom
    }

}
