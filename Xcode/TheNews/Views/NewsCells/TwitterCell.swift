//
//  TwitterCell.swift
//  TheNews
//
//  Created by Daniel on 4/10/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class TwitterCell: NewsProfileCell {    
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

        source.attributedText = article.twitterAttributedFirstLine
        title.text = article.title
    }
}

extension TwitterCell: Configurable {
    static var LogoSize = CGSize(width: 60, height: 60)

    func setup() {
        imageSize = CGSize(width: 310, height: 200)

        line.backgroundColor = .lightGray
        
        title.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        sourceLogo.layer.cornerRadius = TwitterCell.LogoSize.width / 2
        sourceLogo.layer.masksToBounds = true
    }
    
    func config() {
        [line, sourceLogo, source, title, imageView].forEach { contentView.addSubviewForAutoLayout($0) }
        
        let profileInset: CGFloat = 5
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: contentView.topAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            
            sourceLogo.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            sourceLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            sourceLogo.widthAnchor.constraint(equalToConstant: TwitterCell.LogoSize.width),
            sourceLogo.heightAnchor.constraint(equalToConstant: TwitterCell.LogoSize.width),
            
            source.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            source.leadingAnchor.constraint(equalTo: sourceLogo.trailingAnchor, constant: profileInset),
            source.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            source.bottomAnchor.constraint(equalTo: title.topAnchor),
            
            title.leadingAnchor.constraint(equalTo: sourceLogo.trailingAnchor, constant: profileInset),
            contentView.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            
            imageView.leadingAnchor.constraint(equalTo: sourceLogo.trailingAnchor, constant: profileInset),
            imageView.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: imageSizeUnwrapped.height),
        ])
    }
}

private extension Article {
    var twitterAttributedFirstLine: NSAttributedString {
        guard let name = source?.name,
            let date = publishedAt
            else { return NSAttributedString() }
        
        let nameAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        let a = NSMutableAttributedString(string: name, attributes: nameAttribute)
        
        let str = " · \(date.shortTimeAgoSinceDate)"
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
