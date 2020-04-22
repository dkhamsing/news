//
//  LilCell.swift
//  TheNews
//
//  Created by Daniel on 4/18/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class LilCell: UICollectionViewCell {
    var identifier: String?

    private let imageView = UIImageView()
    private let title = UILabel()
    private let content = UILabel()
    private let source = UILabel()
    private let ago = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()

        identifier = nil
        content.text = nil
        title.text = nil
        source.text = nil
        ago.text = nil
        imageView.image = nil
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

extension LilCell: Displayable {
    static var ReuseIdentifier = "LilCell"
    static var ImageSize = CGSize.zero

    func configure(_ article: Article) {
        title.text = article.title
        content.text = article.descriptionOrContent
        ago.text = article.publishedAt
        ago.text = article.lilAgo
        identifier = article.identifier
        source.text = article.source?.name
    }

    func update(image: UIImage?, identifier ident: String?) {
        guard identifier == ident else { return }
        imageView.image = image

        guard imageView.layer.sublayers?.count == nil else { return }
        imageView.addGradient()
    }
}
extension LilCell: Configurable {
    func setup() {
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
        [imageView, source, title, content, ago].forEach { contentView.autolayoutAddSubview($0) }

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

private extension Article {
    var lilAgo: String {
        guard let publishedAt = self.publishedAt else { return "" }
        
        let f = ISO8601DateFormatter()
        let da = f.date(from: publishedAt)
        guard let date = da else { return ""}
        
        return date.lilTimeAgoSinceDate()
    }
}

private extension Date {
    func lilTimeAgoSinceDate() -> String {
        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"

        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }

        return "a moment ago"
    }
}
