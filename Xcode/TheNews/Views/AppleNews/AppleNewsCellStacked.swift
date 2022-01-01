//
//  Created by Daniel on 12/19/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class AppleNewsCellStacked: NewsCell {

    static let identifier: String = "AppleNewsCellStacked"

    private static let logoSize = CGSize(width: 20, height: 20)

    fileprivate var stackLeft = AppleNewsStackedView()
    fileprivate var stackRight = AppleNewsStackedView()

    override func config() {
        super.config()

        [stackLeft, stackRight].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            stackLeft.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            stackLeft.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),

            stackRight.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: stackRight.trailingAnchor),
            stackRight.leadingAnchor.constraint(equalTo: stackLeft.trailingAnchor, constant: 26),

            contentView.bottomAnchor.constraint(equalTo: stackLeft.bottomAnchor, constant: inset),
            contentView.bottomAnchor.constraint(equalTo: stackRight.bottomAnchor, constant: inset),

            stackLeft.widthAnchor.constraint(equalTo: stackRight.widthAnchor)
        ])
    }

    func load(_ articles: [Article]) {
        if let first = articles.first {
            stackLeft.load(first)
        }

        let index = 1
        let isIndexValid = articles.indices.contains(index)
        if isIndexValid {
            let second = articles[index]
            stackRight.load(second)
        }
    }

}

private class AppleNewsStackedView: UIView {

    static let imageHeight: CGFloat = 120
    private static let logoSize = CGSize(width: 20, height: 20)

    let articleImageView = UIImageView()
    let logo = UIImageView()

    let title = UILabel()
    let ago = UILabel()
    let source = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func build() {
        title.numberOfLines = 4

        let fontSize: CGFloat = 15
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        if let descriptor = systemFont.fontDescriptor.withDesign(.default) {
            title.font = UIFont(descriptor: descriptor, size: fontSize)
        }

        articleImageView.backgroundColor = .secondarySystemBackground
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        articleImageView.layer.cornerRadius = 4
        articleImageView.layer.masksToBounds = true

        ago.font = .boldSystemFont(ofSize: 12)
        ago.textColor = .secondaryLabel

        source.font = .boldSystemFont(ofSize: 12)

        [articleImageView, title, ago, source, logo].forEach {
            self.addSubviewForAutoLayout($0)
        }

        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: self.topAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: AppleNewsStackedView.imageHeight),

            logo.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            logo.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: AppleNewsStackedView.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: AppleNewsStackedView.logoSize.width),

            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: 4),
            source.centerYAnchor.constraint(equalTo: logo.centerYAnchor),

            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 3),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            ago.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            ago.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ago.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func load(_ article: Article) {
        articleImageView.image = nil
        let width: CGFloat = UIScreen.main.bounds.width / 2
        let size = CGSize(width: width, height: AppleNewsStackedView.imageHeight)
        articleImageView.load(urlString: article.urlToImage, size: size, downloader: ImageDownloader.shared)

        title.text = article.titleDisplay
        ago.text = article.ago
        source.text = article.source?.name

        logo.load(urlString: article.urlToSourceLogo, size: AppleNewsStackedView.logoSize, downloader: ImageDownloader.shared)
    }

}
