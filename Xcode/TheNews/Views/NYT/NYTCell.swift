//
//  Created by Daniel on 12/12/20.
//

import UIKit

class NYTCell: NewsCell {

    static let identifier: String = "NYTCell"

    override func config() {
        super.config()

        title.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 25)

        summary.font = UIFont(name: "Times New Roman", size: 18)
        summary.textColor = .secondaryLabel

        source.textColor = .systemGray4
        source.font = UIFont(name: "Times New Roman", size: 11)

        [title, summary, articleImageView, source].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 200
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),

            summary.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            summary.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor, constant: inset),

            articleImageView.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: inset),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: inset),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            source.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 3),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: source.trailingAnchor, constant: inset),

            contentView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: 28)
        ])
    }

    func load(article: Article, downloader: ImageDownloader) {
        title.text = article.titleDisplay
        summary.text = article.description
        source.text = article.source?.name
        load(urlString: article.urlToImage, downloader: downloader)
    }

}
