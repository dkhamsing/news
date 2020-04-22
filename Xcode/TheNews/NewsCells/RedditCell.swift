//
//  RedditCell.swift
//  TheNews
//
//  Created by Daniel on 4/11/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class RedditCell: UICollectionViewCell {
    var identifier: String?

    private let imageView = UIImageView()    
    private let profile = UIImageView()
    private let top = UILabel()
    private let label = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()
        
        identifier = nil
        imageView.image = nil
        profile.image = nil
        top.attributedText = nil
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

extension RedditCell: Displayable {
    static var ReuseIdentifier = "RedditCell"
    static var ImageSize = CGSize(width: 100, height: 70)
    
    func configure(_ article: Article) {
        top.attributedText = article.redditAttributed
        label.text = article.title
        identifier = article.identifier
        
        guard let image = article.profileImage else { return }
        profile.image = image.withTintColor(.gray, renderingMode: .alwaysOriginal)
    }

    func update(image: UIImage?, identifier ident: String?) {
        guard identifier == ident else { return }
        imageView.image = image
    }
}

extension RedditCell: Configurable {
    func setup() {
        contentView.backgroundColor = .white
        
        label.numberOfLines = 0
        top.numberOfLines = 2
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
    }
    
    func config() {
        [profile, top, label, imageView].forEach { contentView.autolayoutAddSubview($0) }
        
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profile.widthAnchor.constraint(equalToConstant: 35),
            profile.heightAnchor.constraint(equalToConstant: 35),
            
            top.topAnchor.constraint(equalTo: profile.topAnchor, constant: 2),
            top.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 10),
            
            label.leadingAnchor.constraint(equalTo: profile.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imageView.topAnchor.constraint(equalTo: label.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: RedditCell.ImageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: RedditCell.ImageSize.height),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }
}

private extension Article {
    var redditAttributed: NSAttributedString {
        guard let name = source?.name,
            let publishedAt = self.publishedAt else {
                return NSAttributedString()
        }
        
        let f = ISO8601DateFormatter()
        let da = f.date(from: publishedAt)
        guard let date = da else { return NSAttributedString() }
        
        let fontSize: CGFloat = 12
        
        let aAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize),
            .foregroundColor: UIColor.gray
        ]
        let a = NSMutableAttributedString(string: "r/", attributes: aAttribute)
        
        let bAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: fontSize),
            .foregroundColor: UIColor.gray
        ]
        let b = NSAttributedString(string: "news\n", attributes: bAttribute)
        a.append(b)
        
        let user = "u/\(name)".replacingOccurrences(of: " ", with: "")
        let str = "\(user) · \(date.shortTimeAgoSinceDate())"
        let c = NSAttributedString(string: str, attributes: aAttribute)
        a.append(c)
        
        return a
    }
}
