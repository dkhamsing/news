//
//  FacebookCell.swift
//  TheNews
//
//  Created by Daniel on 4/10/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class FacebookCell: UICollectionViewCell {
    var identifier: String?

    private let imageView = UIImageView()    
    private let line = UIView()
    private let profile = UIImageView()
    private let name = UILabel()
    private let time = UILabel()
    private let content = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()

        identifier = nil
        imageView.image = nil
        profile.image = nil
        time.attributedText = nil
        content.attributedText = nil
        name.attributedText = nil
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

extension FacebookCell: Displayable {
    static var ReuseIdentifier: String = "FacebookCell"
    static var ImageSize: CGSize = CGSize(width: 420, height: 260)
    
    func configure(_ article: Article) {
        name.attributedText = article.facebookAttributedName
        time.attributedText = article.facebookAgo
        content.attributedText = article.facebookAttributedContent
        identifier = article.identifier
        
        guard let image = article.profileImage else { return }
        profile.image = image.withTintColor(.facebookBlue, renderingMode: .alwaysOriginal)
    }

    func update(image: UIImage?, identifier ident: String?) {
        guard identifier == ident else { return }
        imageView.image = image
    }
}

extension FacebookCell: Configurable {
    func setup() {
        line.backgroundColor = UIColor.colorFor(red: 210, green: 210, blue: 210)
        
        content.numberOfLines = 0
        
        imageView.contentMode = .scaleAspectFit
    }
    
    func config() {
        [line, profile, name, time, content, imageView].forEach { contentView.autolayoutAddSubview($0) }
        
        NSLayoutConstraint.activate([
            line.topAnchor.constraint(equalTo: contentView.topAnchor),
            line.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 8),
            
            profile.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 15),
            profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profile.widthAnchor.constraint(equalToConstant: 60),
            profile.heightAnchor.constraint(equalToConstant: 60),
            
            name.topAnchor.constraint(equalTo: profile.topAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 10),
            
            time.topAnchor.constraint(equalTo: name.bottomAnchor),
            time.leadingAnchor.constraint(equalTo: profile.trailingAnchor, constant: 10),
            
            content.topAnchor.constraint(equalTo: profile.bottomAnchor, constant: 2),
            content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13),
            content.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13),
            
            imageView.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: FacebookCell.ImageSize.height),
        ])
    }
}

private extension Article {
    var facebookAttributedName: NSAttributedString {
        guard let name = source?.name else { return NSAttributedString() }
        
        let nameAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        
        return NSAttributedString(string: name, attributes: nameAttribute)
    }
    
    var facebookAttributedContent: NSAttributedString {
        guard let t = title else {
            return NSAttributedString()
        }
        
        let nameAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
        ]
        
        return NSAttributedString(string: t, attributes: nameAttribute)
    }
    
    var facebookAgo: NSAttributedString {
        guard let publishedAt = self.publishedAt else {
            return NSAttributedString()
        }
        
        let f = ISO8601DateFormatter()
        let da = f.date(from: publishedAt)
        guard let date = da else {
            return NSAttributedString()
        }
        
        let nameAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.gray
        ]
        
        return NSAttributedString(string: date.facebookTimeAgoSinceDate(), attributes: nameAttribute)
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
