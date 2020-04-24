//
//  LilCell.swift
//  TheNews
//
//  Created by Daniel on 4/18/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class LilCell: NewsCell {
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
        content.text = article.descriptionOrContent
        ago.text = article.publishedAt?.timeAgoSinceDate
        source.text = article.source?.name
    }

    override func update(image: UIImage?, matchingIdentifier: String?) {
        super.update(image: image, matchingIdentifier: matchingIdentifier)

        guard imageView.layer.sublayers?.count == nil else { return }
        imageView.addGradient()
    }
}

extension LilCell: Configurable {
    func setup() {
        imageSize = CGSize(width: 500, height: 300)

        title.numberOfLines = 0
        title.textColor = .white
        title.font = .boldSystemFont(ofSize: 24)

        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true

        content.numberOfLines = 0
        content.font = .systemFont(ofSize: 16)
        content.textColor = .lightGray

        source.textColor = .gray
        source.font = .systemFont(ofSize: 15)

        ago.font = source.font
        ago.textColor = source.textColor
    }

    func config() {
        [imageView, source, title, content, ago].forEach { contentView.addSubviewForAutoLayout($0) }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            ago.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ago.heightAnchor.constraint(equalToConstant: 30),
            ago.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),

            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            title.bottomAnchor.constraint(equalTo: content.topAnchor, constant: -6),

            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            content.bottomAnchor.constraint(equalTo: ago.topAnchor),

            source.bottomAnchor.constraint(equalTo: title.topAnchor),
            source.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            source.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
