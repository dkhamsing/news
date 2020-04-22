//
//  TwitterCell.swift
//  TheNews
//
//  Created by Daniel on 4/10/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class TwitterCell: UICollectionViewCell {
    var identifier: String?
    
    private let imageView = UIImageView()
    private let line = UIView()
    private let profile = UIImageView()
    private let top = UILabel()
    private let label = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        identifier = nil
        imageView.image = nil
        profile.image = nil
        top.text = nil
        label.attributedText = nil
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

extension TwitterCell: Displayable {
    static var ReuseIdentifier = "TwitterCell"
    static var ImageSize = CGSize(width: 310, height: 200)
    
    func configure(_ article: Article) {
        top.attributedText = article.twitterAttributedFirstLine
        label.text = article.title
        identifier = article.identifier
        
        guard let image = article.profileImage else { return }
        profile.image = image.withTintColor(.twitterBlue, renderingMode: .alwaysOriginal)
    }

    func update(image: UIImage?, identifier ident: String?) {
        guard identifier == ident else { return }
        imageView.image = image
    }
}

extension TwitterCell: Configurable {
    func setup() {
        line.backgroundColor = .lightGray
        
        label.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
    }
    
    func config() {
        [line, profile, top, label, imageView].forEach { contentView.autolayoutAddSubview($0) }
        
        let profileInset: CGFloat = 5
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: contentView.topAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            
            profile.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profile.widthAnchor.constraint(equalToConstant: 60),
            profile.heightAnchor.constraint(equalToConstant: 60),
            
            top.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            top.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: profileInset),
            top.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            top.bottomAnchor.constraint(equalTo: label.topAnchor),
            
            label.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: profileInset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            
            imageView.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: profileInset),
            imageView.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: TwitterCell.ImageSize.height),
        ])
    }
}

private extension Article {
    var twitterAttributedFirstLine: NSAttributedString {
        guard let name = source?.name,
            let publishedAt = self.publishedAt
            else { return NSAttributedString() }

        let f = ISO8601DateFormatter()
        let da = f.date(from: publishedAt)
        guard let date = da else { return NSAttributedString() }
        
        let nameAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        let a = NSMutableAttributedString(string: name, attributes: nameAttribute)
        
        let str = " · \(date.shortTimeAgoSinceDate())"
        let titleAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17),
            .foregroundColor: UIColor.gray
        ]
        let b = NSAttributedString(string: str, attributes: titleAttribute)
        a.append(b)
        
        return a
    }
}

private extension UIColor {
    static let twitterBlue = UIColor.colorFor(red: 29, green: 161, blue: 242)
}
