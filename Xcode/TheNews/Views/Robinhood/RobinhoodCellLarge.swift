//
//  RobinhoodCellLarge.swift
//  TheNews
//
//  Created by Daniel on 12/28/21.
//  Copyright © 2021 dk. All rights reserved.
//

import UIKit

class RobinhoodCellLarge: NewsCell {

    static let identifier: String = "RobinhoodCellLarge"

    override func config() {
        super.config()

        articleImageView.layer.cornerRadius = 4
        articleImageView.layer.masksToBounds = true

        [source, title, articleImageView].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        NSLayoutConstraint.activate([
            source.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            source.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),

            title.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 20),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            articleImageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 190),

            contentView.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 30)
        ])

    }

    func load(_ rh: rhArticle) {
        title.attributedText = rh.title
        source.attributedText = rh.top
        load(urlString: rh.url, downloader: ImageDownloader.shared)
    }

}
