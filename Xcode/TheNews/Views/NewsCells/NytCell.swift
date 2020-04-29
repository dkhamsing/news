//
//  NytCell.swift
//  TheNews
//
//  Created by Daniel on 4/11/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class NytCell: NewsCell {    
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
        content.text = article.descriptionOrContent
        source.text = article.source?.name
    }
}

extension NytCell: Configurable {
    func setup() {
        imageSize = CGSize(width: 370, height: 230)

        line.backgroundColor = .lightGray
        
        imageView.contentMode = .scaleAspectFit
        
        title.numberOfLines = 0
        title.font = UIFont(name: "TimesNewRomanPS-BoldMT", size: 23)
        
        content.numberOfLines = 0
        content.font = UIFont(name: "Times New Roman", size: 18)
        content.textColor = .colorForSameRgbValue(80)

        source.textColor = .lightGray
        source.font = UIFont.systemFont(ofSize: 12)
    }
    
    func config() {
        [line, title, content, imageView, source].forEach { contentView.addSubviewForAutoLayout($0) }
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: contentView.topAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            contentView.trailingAnchor.constraint(equalTo: line.trailingAnchor, constant: 25),
            line.heightAnchor.constraint(equalToConstant: 0.5),
            
            title.leadingAnchor.constraint(equalTo: line.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: line.trailingAnchor),
            title.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 15),
            
            content.leadingAnchor.constraint(equalTo: line.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: line.trailingAnchor),
            content.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 5),

            imageView.leadingAnchor.constraint(equalTo: line.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: line.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSizeUnwrapped.height),
            
            source.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: source.bottomAnchor, constant: 8),
            source.trailingAnchor.constraint(equalTo: line.trailingAnchor),
        ])
    }
}
