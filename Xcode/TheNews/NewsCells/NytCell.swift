//
//  NytCell.swift
//  TheNews
//
//  Created by Daniel on 4/11/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class NytCell: UICollectionViewCell {
    var identifier: String?

    private let imageView = UIImageView()    
    private let line = UIView()
    private let title = UILabel()
    private let content = UILabel()
    private let sourceLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        identifier = nil
        imageView.image = nil
        title.attributedText = nil
        content.attributedText = nil
        sourceLabel.attributedText = nil
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

extension NytCell: Displayable {
    static var ReuseIdentifier = "NytCell"
    static var ImageSize = CGSize(width: 370, height: 230)
    
    func configure(_ article: Article) {
        title.attributedText = article.nytAttributedTitle
        content.attributedText = article.nytAttributedContent        
        sourceLabel.text = article.source?.name
        identifier = article.identifier        
    }

    func update(image: UIImage?, identifier ident: String?) {
        guard identifier == ident else { return }
        imageView.image = image
    }
}

extension NytCell: Configurable {
    func setup() {
        line.backgroundColor = .lightGray
        
        imageView.contentMode = .scaleAspectFit
        
        title.numberOfLines = 0
        
        content.numberOfLines = 0
        
        sourceLabel.textColor = .lightGray
        sourceLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    func config() {
        [line, title, content, imageView, sourceLabel].forEach { contentView.autolayoutAddSubview($0) }
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: contentView.topAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            
            title.leadingAnchor.constraint(equalTo: line.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: line.trailingAnchor),
            title.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 15),
            
            content.leadingAnchor.constraint(equalTo: line.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: line.trailingAnchor),
            content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            content.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -5),
            
            imageView.leadingAnchor.constraint(equalTo: line.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: line.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: NytCell.ImageSize.height),
            
            sourceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            sourceLabel.trailingAnchor.constraint(equalTo: line.trailingAnchor),
        ])
    }
}

private extension Article {
    
    var nytAttributedTitle: NSAttributedString {
        guard let t = title,
            let font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 23)
            else { return NSAttributedString()}
        
        let nameAttribute: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        
        return NSAttributedString(string: t, attributes: nameAttribute)
    }
    
    var nytAttributedContent: NSAttributedString {
        guard let font = UIFont(name: "Times New Roman", size: 18) else { return NSAttributedString() }
        
        let color = UIColor.colorFor(red: 80, green: 80, blue: 80)
        let attribute: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        return NSAttributedString(string: descriptionOrContent ?? "", attributes: attribute)
    }
}
