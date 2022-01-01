//
//  Created by Daniel on 12/12/20.
//

import UIKit

class BBCCell: NewsCell {

    static let identifier: String = "BBCCell"

    private static let imageWidth: CGFloat = 125
    private static let imageHeight: CGFloat = 75
    private static let inset: CGFloat = 10

    private var main = UIView()
    private var badge = UILabel()

    override func configure() {
        super.configure()

        title.numberOfLines = 3
        title.font = .systemFont(ofSize: 15)

        articleImageView.backgroundColor = .secondarySystemBackground
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true

        badge.backgroundColor = .red
        badge.textColor = .white
        badge.font = UIFont.systemFont(ofSize: 12)
        badge.textAlignment = .center

        ago.textColor = .secondaryLabel
        ago.font = .systemFont(ofSize: 15)

        main = UIView()
        contentView.addSubviewForAutoLayout(main)

        let inset: CGFloat = BBCCell.inset
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

            title.topAnchor.constraint(equalTo: main.topAnchor, constant: inset),
            title.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: inset),
            main.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            ago.topAnchor.constraint(equalTo: title.bottomAnchor, constant: inset),
            ago.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: inset),

            main.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset)
        ])

        articleImageView.addSubviewForAutoLayout(badge)

        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            badge.widthAnchor.constraint(equalToConstant: 30),
            badge.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func load(article: Article, downloader: ImageDownloader) {
        title.text = article.titleDisplay
        ago.text = article.ago

        let size = CGSize(width: BBCCell.imageWidth, height: BBCCell.imageHeight)
        load(urlString: article.image, downloader: downloader, size: size)
    }

    func loadBadge(number: Int) {
        badge.text = String(number + 1)
    }

}
