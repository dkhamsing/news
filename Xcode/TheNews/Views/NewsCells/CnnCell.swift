//
//  CnnCell.swift
//  TheNews
//
//  Created by Daniel on 4/13/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class CnnCell: NewsCell {        
    private let separator = UIView()
 
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

        ago.text = article.publishedAt?.shortTimeAgoSinceDate
        source.text = article.source?.name?.uppercased()
        title.text = article.title
        content.text = article.descriptionOrContent
    }

    override func update(image: UIImage?, matchingIdentifier: String?) {
        super.update(image: image, matchingIdentifier: matchingIdentifier)

        guard imageView.layer.sublayers?.count == nil else { return }
        imageView.addGradient()
    }
}

extension CnnCell: Configurable {
    func setup() {
        imageSize = CGSize(width: 450, height: 280)

        contentView.backgroundColor = .white
        
        ago.textColor = .cnnRed
        ago.font = UIFont.systemFont(ofSize: 14)
        
        source.textColor = .white
        source.font = UIFont.boldSystemFont(ofSize: 12)
        
        title.numberOfLines = 0
        title.textColor = .white
        
        content.numberOfLines = 0
        content.textColor = .darkGray
        content.font = UIFont.systemFont(ofSize: 14)
        
        imageView.contentMode = .scaleAspectFit
        
        line.backgroundColor = UIColor.colorFor(red: 221, green: 223, blue: 225)
        
        separator.backgroundColor = UIColor.colorFor(red: 241, green: 242, blue: 246)
    }
    
    func config() {
        [imageView, source, title, content, ago, line, separator].forEach { contentView.addSubviewForAutoLayout($0) }
        
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSizeUnwrapped.height),
            
            source.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: inset),
            source.heightAnchor.constraint(equalToConstant: 35),
            source.bottomAnchor.constraint(equalTo: title.topAnchor),
            
            title.leadingAnchor.constraint(equalTo: source.leadingAnchor),
            title.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: (-2 * inset)),
            title.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -inset),
            
            content.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: inset),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: (2 * inset)),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: (-2 * inset)),
            
            line.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 10),
            line.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            
            ago.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 10),
            ago.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            ago.heightAnchor.constraint(equalToConstant: 42),
            
            separator.topAnchor.constraint(equalTo: ago.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 10),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

private extension UIColor {
    static let cnnRed = UIColor.colorFor(red: 188, green: 38, blue: 26)
}
