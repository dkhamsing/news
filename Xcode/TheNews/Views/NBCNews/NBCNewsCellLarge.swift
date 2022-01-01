//
//  Created by Daniel on 12/17/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class NBCNewsCellLarge: NewsCell {

    static let identifier: String = "NBCNewsCellLarge"

    private static let imageHeight: CGFloat = 400

    override func config() {
        super.config()

        title.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 32)
        title.numberOfLines = 0
        title.textColor = .white

        source.textColor = .white

        source.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)

        [articleImageView, title, source].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let inset: CGFloat = 22
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: NBCNewsCellLarge.imageHeight),
            contentView.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor),

            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),
            articleImageView.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),

            source.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            title.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 10)
        ])

    }

    func load(article: Article) {
        title.text = article.titleDisplay
        source.text = article.source?.name?.uppercased()

        articleImageView.load(urlString: article.urlToImage, downloader: ImageDownloader.shared) { [weak self] in
            self?.articleImageView.addGradient(count: 0, index: 0)
        }
    }

}
