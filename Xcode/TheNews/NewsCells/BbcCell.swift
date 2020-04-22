//
//  BbcCell.swift
//  TheNews
//
//  Created by Daniel on 4/11/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class BbcCell: UICollectionViewCell {
    var identifier: String?

    private let imageView = UIImageView()
    private let badge = UILabel()
    private let title = UILabel()
    private let ago = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()

        identifier = nil
        imageView.image = nil
        badge.text = nil
        title.attributedText = nil
        ago.attributedText = nil
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

extension BbcCell: Displayable {
    static var ReuseIdentifier = "BbcCell"
    static var ImageSize = CGSize(width: 150, height: 90)
    
    func configure(_ article: Article) {
        title.attributedText = article.bbcAttributedTitle
        ago.attributedText = article.bbcAgo        
        identifier = article.identifier
    }
    
    func configure(badgeNumber: Int) {
        badge.text = "\(badgeNumber)"
    }

    func update(image: UIImage?, identifier ident: String?) {
        guard identifier == ident else { return }
        imageView.image = image
    }
}
extension BbcCell: Configurable {
    func setup() {
        badge.backgroundColor = UIColor.colorFor(red: 177, green: 40, blue: 33)
        badge.textAlignment = .center
        badge.textColor = .white
        badge.font = UIFont.systemFont(ofSize: 12)
        
        contentView.backgroundColor = .white
        
        title.numberOfLines = 3
        
        imageView.contentMode = .scaleAspectFit
    }
    
    func config() {
        [title, ago, imageView, badge].forEach { contentView.autolayoutAddSubview($0) }
        
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: contentView.topAnchor),
            badge.widthAnchor.constraint(equalToConstant: 30),
            badge.heightAnchor.constraint(equalToConstant: 30),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: BbcCell.ImageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: BbcCell.ImageSize.height),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            title.bottomAnchor.constraint(equalTo: ago.topAnchor),
            
            ago.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            ago.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            ago.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        ])
    }
}

private extension Article {
    var bbcAttributedTitle: NSAttributedString {
        guard let t = title else { return NSAttributedString() }
        
        let nameAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15)
        ]
        
        return NSAttributedString(string: t, attributes: nameAttribute)
    }
    
    var bbcAgo: NSAttributedString {
        guard let publishedAt = self.publishedAt else { return NSAttributedString() }
        
        let f = ISO8601DateFormatter()
        let da = f.date(from: publishedAt)
        guard let date = da else { return NSAttributedString() }
        
        let nameAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.gray
        ]
        
        return NSAttributedString(string: date.shortTimeAgoSinceDate(), attributes: nameAttribute)
    }
}
