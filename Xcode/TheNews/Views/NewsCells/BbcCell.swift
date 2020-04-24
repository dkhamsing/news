//
//  BbcCell.swift
//  TheNews
//
//  Created by Daniel on 4/11/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class BbcCell: NewsCell {
    private let badge = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()

        badge.text = nil
    }
    
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
        ago.text = article.publishedAt?.shortTimeAgoSinceDate
    }
}

extension BbcCell {
    func configure(badgeNumber: Int) {
        badge.text = "\(badgeNumber)"
    }
}

extension BbcCell: Configurable {
    func setup() {
        imageSize = CGSize(width: 150, height: 90)

        badge.backgroundColor = UIColor.colorFor(red: 177, green: 40, blue: 33)
        badge.textAlignment = .center
        badge.textColor = .white
        badge.font = UIFont.systemFont(ofSize: 12)
        
        contentView.backgroundColor = .white
        
        title.numberOfLines = 3
        title.font = .systemFont(ofSize: 15)
        
        imageView.contentMode = .scaleAspectFit

        ago.font = .systemFont(ofSize: 15)
        ago.textColor = .gray

    }
    
    func config() {
        [title, ago, imageView, badge].forEach { contentView.addSubviewForAutoLayout($0) }
        
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: contentView.topAnchor),
            badge.widthAnchor.constraint(equalToConstant: 30),
            badge.heightAnchor.constraint(equalToConstant: 30),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSizeUnwrapped.width),
            imageView.heightAnchor.constraint(equalToConstant: imageSizeUnwrapped.height),
            
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
