//
//  Created by Daniel on 12/12/20.
//

import UIKit

class CNNCell: NewsCell {

    static let identifier: String = "CNNCell"

    override func config() {
        super.config()

        summary.font = .boldSystemFont(ofSize: 20)

        source.textColor = .white
        source.font = UIFont.boldSystemFont(ofSize: 12)

        ago.textColor = .secondaryLabel
        ago.font = .preferredFont(forTextStyle: .caption1)

        [articleImageView, summary, ago].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }

        let imageHeight: CGFloat = 210
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            summary.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset),
            summary.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor ),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor ),

            ago.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: inset),
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),

            contentView.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset)
        ])
    }

    func load(article: Article, downloader: ImageDownloader) {
        summary.text = article.titleDisplay
        source.text = article.source?.name?.uppercased()
        ago.text = article.ago?.uppercased()
        load(urlString: article.urlToImage, downloader: downloader)
    }

}
