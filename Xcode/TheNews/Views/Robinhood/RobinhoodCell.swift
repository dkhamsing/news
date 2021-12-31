//
//  RobinhoodCell.swift
//  TheNews
//
//  Created by Daniel on 12/28/21.
//  Copyright © 2021 dk. All rights reserved.
//

import UIKit

class RobinhoodCell: NewsCell {

    static let identifier: String = "RobinhoodCell"

    override func config() {
        super.config()

        articleImageView.layer.cornerRadius = 6
        articleImageView.layer.masksToBounds = true

        [articleImageView, source, title].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 55
        let inset: CGFloat = 15
        let topBottomInset: CGFloat = 25
        NSLayoutConstraint.activate([
            source.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            source.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topBottomInset),

            articleImageView.topAnchor.constraint(equalTo: source.topAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            articleImageView.widthAnchor.constraint(equalToConstant: imageHeight),

            title.topAnchor.constraint(equalTo: source.bottomAnchor, constant: inset),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: articleImageView.bottomAnchor, constant: inset),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: title.bottomAnchor, constant: topBottomInset)
        ])

    }

    func load(_ rh: rhArticle) {
        title.attributedText = rh.title
        source.attributedText = rh.top
        load(urlString: rh.url, downloader: ImageDownloader.shared)
    }

}
