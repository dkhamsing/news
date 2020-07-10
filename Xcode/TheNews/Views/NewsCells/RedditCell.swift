//
//  RedditCell.swift
//  TheNews
//
//  Created by Daniel on 4/11/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class RedditCell: NewsProfileCell {
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

        source.attributedText = article.redditAttributed
        title.text = article.title
    }
}

// TODO: reddit cell height seems wrong
extension RedditCell: Configurable {
    static var LogoSize = CGSize(width: 35, height: 35)

    func setup() {
        imageSize = CGSize(width: 100, height: 70)

        contentView.backgroundColor = .systemBackground
        
        title.numberOfLines = 0

        source.numberOfLines = 2
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true

        sourceLogo.layer.cornerRadius = RedditCell.LogoSize.width / 2
        sourceLogo.layer.masksToBounds = true
    }
    
    func config() {
        [sourceLogo, source, title, imageView].forEach { contentView.addSubviewForAutoLayout($0) }
        
        NSLayoutConstraint.activate([
            sourceLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            sourceLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            sourceLogo.widthAnchor.constraint(equalToConstant: RedditCell.LogoSize.width),
            sourceLogo.heightAnchor.constraint(equalToConstant: RedditCell.LogoSize.width),
            
            source.topAnchor.constraint(equalTo: sourceLogo.topAnchor, constant: 2),
            source.leadingAnchor.constraint(equalTo: sourceLogo.trailingAnchor, constant: 10),
            
            title.leadingAnchor.constraint(equalTo: sourceLogo.leadingAnchor),
            imageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 15),
            title.topAnchor.constraint(equalTo: sourceLogo.bottomAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 15),
            
            contentView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            imageView.topAnchor.constraint(equalTo: title.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSizeUnwrapped.width),
            imageView.heightAnchor.constraint(equalToConstant: imageSizeUnwrapped.height),
            contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
        ])
    }
}

private extension Article {
    var redditAttributed: NSAttributedString {
        guard
            let name = source?.name,
            let date = publishedAt else { return NSAttributedString() }
        
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
        let str = "\(user) · \(date.shortTimeAgoSinceDate)"
        let c = NSAttributedString(string: str, attributes: aAttribute)
        a.append(c)
        
        return a
    }
}
