//
//  FacebookCell.swift
//  TheNews
//
//  Created by Daniel on 4/10/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class FacebookCell: NewsProfileCell {  
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
        
        source.text = article.source?.name
        ago.text = article.publishedAt?.facebookTimeAgoSinceDate()
        title.text = article.title
    }
}

extension FacebookCell: Configurable {
    static var LogoSize = CGSize(width: 60, height: 60)

    func setup() {
        imageSize = CGSize(width: 420, height: 260)

        line.backgroundColor = UIColor.colorFor(red: 210, green: 210, blue: 210)
        
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 15)
        
        imageView.contentMode = .scaleAspectFit

        source.font = .boldSystemFont(ofSize: 17)

        sourceLogo.layer.cornerRadius = FacebookCell.LogoSize.width / 2
        sourceLogo.layer.masksToBounds = true

        ago.font = .systemFont(ofSize: 15)
        ago.textColor = .gray
    }
    
    func config() {
        [line, sourceLogo, source, ago, title, imageView].forEach { contentView.addSubviewForAutoLayout($0) }
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: contentView.topAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 8),
            
            sourceLogo.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 15),
            sourceLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            sourceLogo.widthAnchor.constraint(equalToConstant: FacebookCell.LogoSize.width),
            sourceLogo.heightAnchor.constraint(equalToConstant: FacebookCell.LogoSize.width),
            
            source.topAnchor.constraint(equalTo: sourceLogo.topAnchor, constant: 10),
            source.leadingAnchor.constraint(equalTo: sourceLogo.trailingAnchor, constant: 10),
            
            ago.topAnchor.constraint(equalTo: source.bottomAnchor),
            ago.leadingAnchor.constraint(equalTo: sourceLogo.trailingAnchor, constant: 10),
            
            title.topAnchor.constraint(equalTo: sourceLogo.bottomAnchor, constant: 2),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            contentView.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: 13),
            
            imageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: imageSizeUnwrapped.height),
        ])
    }
}

private extension Date {
    func facebookTimeAgoSinceDate() -> String {
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "year" : "\(interval)" + " " + "years"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "month" : "\(interval)" + " " + "months"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "day" : "\(interval)" + " " + "days"
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "hr" : "\(interval)" + " " + "hrs"
            
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "min" : "\(interval)" + " " + "mins"
        }
        
        return "a moment ago"
    }
}

private extension UIColor {
    static let facebookBlue = UIColor.colorFor(red: 66, green: 103, blue: 178)
}
