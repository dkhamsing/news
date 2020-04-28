//
//  WsjCell.swift
//  TheNews
//
//  Created by Daniel on 4/24/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class WsjCell: NewsCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configure(_ article: Article) {
        super.configure(article)

        title.text = article.title
        content.attributedText = article.wsjAttributedContent
        source.text = article.source?.name?.uppercased()
        ago.text = article.publishedAt?.timeAgoSinceDate.uppercased()
    }
}

extension WsjCell: Configurable {
    func setup() {
        imageSize = CGSize(width: 414, height: 250)

        line.backgroundColor = .colorFor(red: 241, green: 242, blue: 243)

        imageView.contentMode = .scaleAspectFit

        title.numberOfLines = 0
        title.font = UIFont(name: "Palatino-Bold", size: 32)

        content.numberOfLines = 0

        source.font = UIFont(name: "AvenirNextCondensed-Medium", size: 13)
        source.textColor = .colorFor(red: 98, green: 98, blue: 99)

        ago.font = source.font
        ago.textColor = .gray
    }

    func config() {
        [source, imageView, title, content, ago, line].forEach { contentView.addSubviewForAutoLayout($0) }

        NSLayoutConstraint.activate([
            source.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            source.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            source.heightAnchor.constraint(equalToConstant: 14),

            imageView.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSizeUnwrapped.height),

            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contentView.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: 15),

            content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            content.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            ago.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 20),
            ago.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            line.topAnchor.constraint(equalTo: ago.bottomAnchor, constant: 30),

            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 10),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

private extension Article {
    var wsjAttributedContent: NSAttributedString {
        guard let font = UIFont(name: "Palatino-Roman", size: 17),
            let c = descriptionOrContent
            else { return NSAttributedString() }

        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.2

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: style,
            .foregroundColor: UIColor.gray,
        ]

        let a = NSAttributedString.init(string: c, attributes: attributes)
        return a
    }
}
