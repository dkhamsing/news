//
//  CashAppCell.swift
//  TheNews
//
//  Created by Daniel on 12/28/21.
//  Copyright © 2021 dk. All rights reserved.
//

import UIKit

class CashAppCell: NewsCell {

    static let identifier: String = "CashAppCell"
    private static let logoSize = CGSize(width: 40, height: 40)

    override func config() {
        super.config()

        source.font = .rounded(ofSize: 16, weight: .semibold)

        ago.font = .rounded(ofSize: 13, weight: .semibold)
        ago.textColor = .tertiaryLabel

        logo.backgroundColor = .tertiarySystemGroupedBackground
        logo.layer.cornerRadius = CashAppCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        [logo, source, ago, title].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }

        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: CashAppCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: CashAppCell.logoSize.width),

            source.topAnchor.constraint(equalTo: logo.topAnchor, constant: 2),
            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),

            ago.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 4),
            ago.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),

            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            contentView.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: 18)
        ])
    }

    func load(article: Article) {
        source.text = article.source?.name
        ago.text = article.ago?.uppercased()
        title.attributedText = article.attributedTitle
        loadLogo(urlString: article.urlToSourceLogo, size: CashAppCell.logoSize)
    }

}

private extension Article {
    var attributedTitle: NSAttributedString? {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.3
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.rounded(ofSize: 16, weight: .semibold),
                                                         .paragraphStyle: style]

        return NSAttributedString(string: titleDisplay, attributes: attributes)
    }
}

private extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        guard let descriptor = systemFont.fontDescriptor.withDesign(.rounded) else { return systemFont }

        return UIFont(descriptor: descriptor, size: size)
    }
}
