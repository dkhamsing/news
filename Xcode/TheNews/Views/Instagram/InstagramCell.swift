//
//  InstagramCell.swift
//  TheNews
//
//  Created by Daniel on 9/12/21.
//  Copyright © 2021 dk. All rights reserved.
//

import UIKit

class InstagramCell: NewsCell {

    static let identifier: String = "InstagramCell"
    private static let logoSize = CGSize(width: 32, height: 32)

    override func config() {
        super.config()

        source.font = .boldSystemFont(ofSize: 14)

        logo.backgroundColor = .secondarySystemBackground
        logo.layer.cornerRadius = InstagramCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        [logo, source, title, articleImageView].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }

        let imageHeight: CGFloat = 260
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: InstagramCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: InstagramCell.logoSize.width),

            source.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),

            articleImageView.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            title.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            contentView.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 25)
        ])

    }

    func load(article: Article) {
        source.text = article.username
        title.attributedText = article.text
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: InstagramCell.logoSize)
    }

}

private extension Article {

    var text: NSAttributedString {
        var text = NSMutableAttributedString()

        if let name = username {
            let attr = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
            text = NSMutableAttributedString(string: name, attributes: attr)
        }

        let attr = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        text.append(
            NSAttributedString(string: " \(titleDisplay)", attributes: attr)
        )
        return text
    }

    var username: String? {
        guard let name = source?.name else { return nil }

        return name.lowercased().replacingOccurrences(of: " ", with: "")
    }

}
