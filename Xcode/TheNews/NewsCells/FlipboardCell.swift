//
//  FlipboardCell.swift
//  TheNews
//
//  Created by Daniel on 4/22/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class FlipboardCell: UICollectionViewCell {
    var identifier: String?

    private let line = UIView()
    private let imageView = UIImageView()
    private let title = UILabel()
    private let subtitle = UILabel()
    private let logo = UIImageView()
    private let from = UILabel()
    private let ago = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()

        identifier = nil
        imageView.image = nil
        title.text = nil
        subtitle.attributedText = nil
        logo.image = nil
        from.text = nil
        ago.text = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlipboardCell: Displayable {
    static var ReuseIdentifier = "FlipboardCell"
    static var ImageSize = CGSize(width: 400, height: 240)

    func configure(_ article: Article) {
        identifier = article.identifier

        title.text = article.title
        subtitle.attributedText = article.flipboardAttributedSubtitle
        ago.text = article.flipboardAgo
        from.text = article.source?.name

        logo.image = article.profileImage
        logo.tintColor = .flipboardRed
    }

    func update(image: UIImage?, identifier ident: String?) {
        guard identifier == ident else { return }
        imageView.image = image
    }
}

extension FlipboardCell: Configurable {
    func setup() {
        line.backgroundColor = .flipboardLineGray

        contentView.backgroundColor = .flipboardWhite

        subtitle.numberOfLines = 0

        imageView.contentMode = .scaleAspectFit

        from.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)

        ago.textColor = .flipboardAgoGray
        ago.font = .systemFont(ofSize: 14)

        title.numberOfLines = 0
        title.font = UIFont(name: "TimesNewRomanPSMT", size: 28)
    }

    func config() {
        [line, imageView, title, subtitle, logo, from, ago].forEach { contentView.autolayoutAddSubview($0) }

        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: contentView.topAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 13),

            imageView.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imageView.heightAnchor.constraint(equalToConstant: FlipboardCell.ImageSize.height),

            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
            title.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            subtitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),

            logo.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 15),
            logo.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: 38),
            logo.heightAnchor.constraint(equalToConstant: 38),

            from.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 10),
            from.centerYAnchor.constraint(equalTo: logo.centerYAnchor),

            ago.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 22),
            ago.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            ago.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22),
        ])
    }
}

private extension Article {
    var flipboardAttributedSubtitle: NSAttributedString {
        guard let font = UIFont(name: "AppleSDGothicNeo-Light", size: 15),
            let d = descriptionOrContent
            else { return NSAttributedString() }

        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.2

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: style,
        ]

        return NSAttributedString.init(string: d, attributes: attributes)
    }

    var flipboardAgo: String {
        guard let publishedAt = self.publishedAt else { return "" }

        let f = ISO8601DateFormatter()
        let da = f.date(from: publishedAt)
        guard let date = da else { return "" }

        return date.timeAgoSinceDate()
    }
}

private extension UIColor {
    static let flipboardAgoGray = UIColor.colorFor(red: 171, green: 173, blue: 174)
    static let flipboardLineGray = UIColor.colorFor(red: 231, green: 232, blue: 233)
    static let flipboardRed = UIColor.colorFor(red: 242, green: 38, blue: 38)
    static let flipboardWhite = UIColor.colorFor(red: 254, green: 255, blue: 255)
}
