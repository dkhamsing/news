//
//  Created by Daniel on 12/13/20.
//

import UIKit

class FastNewsCell: NewsCell {

    static let identifier: String = "FastNewsCell"
    private static let logoSize = CGSize(width: 30, height: 30)

    override func config() {
        super.config()

        ago.textColor = .systemGray2
        ago.font = .preferredFont(forTextStyle: .caption2)

        title.font = .preferredFont(forTextStyle: .headline)

        logo.backgroundColor = .secondarySystemBackground
        logo.layer.cornerRadius = FastNewsCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        summary.textColor = .systemGray

        source.font = .preferredFont(forTextStyle: .caption1)

        [logo, ago, summary, source, title].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }

        NSLayoutConstraint.activate([
            ago.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),

            logo.topAnchor.constraint(equalTo: ago.bottomAnchor, constant: 10),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: logo.trailingAnchor),
            logo.widthAnchor.constraint(equalToConstant: FastNewsCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: FastNewsCell.logoSize.width),

            title.topAnchor.constraint(equalTo: ago.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: ago.leadingAnchor),
            logo.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 20),

            summary.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            summary.leadingAnchor.constraint(equalTo: ago.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor),

            source.leadingAnchor.constraint(equalTo: ago.leadingAnchor),
            source.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 5),

            contentView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: 20)
        ])

    }

    func load(article: Article, downloader: ImageDownloader) {
        title.text = article.titleDisplay
        summary.text = article.description
        source.text = article.source?.name?.uppercased()
        ago.text = article.ago?.uppercased()
        loadLogo(urlString: article.urlToSourceLogo, size: FastNewsCell.logoSize, downloader: downloader)
    }

}
