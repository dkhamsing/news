//
//  CnnCell.swift
//  TheNews
//
//  Created by Daniel on 4/13/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class CnnCell: UICollectionViewCell {
    var identifier: String?
    
    private let imageView = UIImageView()
    private let top = UILabel()
    private let imageLabel = UILabel()
    private let content = UILabel()
    private let ago = UILabel()
    private let line = UIView()
    private let separator = UIView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        identifier = nil
        top.text = nil
        imageLabel.text = nil
        content.text = nil
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

extension CnnCell: Displayable {
    static var ReuseIdentifier = "CnnCell"
    static var ImageSize = CGSize.init(width: 450, height: 280)
    
    func configure(_ article: Article) {
        ago.text = article.cnnAgo
        top.text = article.source?.name?.uppercased()
        imageLabel.text = article.title
        content.text = article.descriptionOrContent
        identifier = article.identifier
    }

    func update(image: UIImage?, identifier ident: String?) {
        guard identifier == ident else { return }
        imageView.image = image

        guard imageView.layer.sublayers?.count == nil else { return }
        imageView.addGradient()
    }
}

extension CnnCell: Configurable {
    func setup() {
        contentView.backgroundColor = .white
        
        ago.textColor = .cnnRed
        ago.font = UIFont.systemFont(ofSize: 14)
        
        top.textColor = .white
        top.font = UIFont.boldSystemFont(ofSize: 12)
        
        imageLabel.numberOfLines = 0
        imageLabel.textColor = .white
        
        content.numberOfLines = 0
        content.textColor = .darkGray
        content.font = UIFont.systemFont(ofSize: 14)
        
        imageView.contentMode = .scaleAspectFit
        
        line.backgroundColor = UIColor.colorFor(red: 221, green: 223, blue: 225)
        
        separator.backgroundColor = UIColor.colorFor(red: 241, green: 242, blue: 246)
    }
    
    func config() {
        [imageView, top, imageLabel, content, ago, line, separator].forEach { contentView.autolayoutAddSubview($0) }
        
        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: CnnCell.ImageSize.height),
            
            top.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: inset),
            top.heightAnchor.constraint(equalToConstant: 35),
            top.bottomAnchor.constraint(equalTo: imageLabel.topAnchor),
            
            imageLabel.leadingAnchor.constraint(equalTo: top.leadingAnchor),
            imageLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: (-2 * inset)),
            imageLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -inset),
            
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

private extension Article {
    var cnnAgo: String {
        guard let publishedAt = self.publishedAt else {
            return ""
        }
        
        let f = ISO8601DateFormatter()
        let da = f.date(from: publishedAt)
        guard let date = da else {
            return ""
        }
        
        return date.shortTimeAgoSinceDate()
    }
}

private extension UIColor {
    static let cnnRed = UIColor.colorFor(red: 188, green: 38, blue: 26)
}
