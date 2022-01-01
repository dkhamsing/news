//
//  Created by Daniel on 12/13/20.
//

import UIKit

class FacebookCell: NewsCell {

    static let identifier: String = "FacebookCell"
    private static let logoSize = CGSize(width: 36, height: 36)

    let banner = UILabel()

    override func config() {
        super.config()

        title.font = .preferredFont(forTextStyle: .subheadline)

        source.font = .boldSystemFont(ofSize: 14)

        ago.textColor = .systemGray
        ago.font = .systemFont(ofSize: 14)

        logo.backgroundColor = .secondarySystemBackground
        logo.layer.cornerRadius = FacebookCell.logoSize.width / 2
        logo.layer.masksToBounds = true

        let bannerView = UIView()
        bannerView.backgroundColor = .systemGray6

        banner.font = .preferredFont(forTextStyle: .caption2)
        banner.textColor = .systemGray

        [logo, ago, source, title, articleImageView, bannerView, banner].forEach { item in
            contentView.addSubviewForAutoLayout(item)
        }

        let imageHeight: CGFloat = 260
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.widthAnchor.constraint(equalToConstant: FacebookCell.logoSize.width),
            logo.heightAnchor.constraint(equalToConstant: FacebookCell.logoSize.width),

            source.topAnchor.constraint(equalTo: logo.topAnchor),
            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),

            ago.topAnchor.constraint(equalTo: source.bottomAnchor),
            ago.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),

            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: title.trailingAnchor),

            articleImageView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 12),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),

            bannerView.topAnchor.constraint(equalTo: articleImageView.bottomAnchor),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 40),
            contentView.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor),

            banner.topAnchor.constraint(equalTo: articleImageView.bottomAnchor),
            banner.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            banner.heightAnchor.constraint(equalToConstant: 40),

            contentView.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 15)
        ])

    }

    func load(article: Article) {
        title.text = article.titleDisplay
        source.text = article.source?.name
        ago.text = article.ago
        banner.text = article.banner
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: FacebookCell.logoSize)
    }

}

private extension Article {

    var banner: String? {
        return url?.host?
            .replacingOccurrences(of: "www.", with: "")
            .uppercased()
    }

}
