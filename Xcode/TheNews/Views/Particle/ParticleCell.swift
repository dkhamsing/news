import UIKit

class ParticleCell: NewsCell {

    static let identifier: String = "ParticleCell"

    override func config() {
        super.config()
        
        ago.textColor = .systemGray5
        ago.font = .preferredFont(forTextStyle: .caption1)
        
        title.font = .systemFont(ofSize: 20, weight: .heavy)
        title.textColor = .systemGray6
        
        summary.font = .preferredFont(forTextStyle: .callout)
        summary.textColor = .systemGray4
        
        let cardView = UIView()
        cardView.backgroundColor = .systemGray
        cardView.layer.cornerRadius = 12
        cardView.clipsToBounds = true
        contentView.addSubviewForAutoLayout(cardView)
        
        let inset: CGFloat = 15
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            cardView.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
        ])
        
        let banner = UIView()
        banner.backgroundColor = .systemFill
        
        [articleImageView, banner].forEach {
            cardView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 400
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            banner.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            banner.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 0),
            
            cardView.bottomAnchor.constraint(equalTo: banner.bottomAnchor)
        ])
        
        [title, ago, summary].forEach {
            cardView.addSubviewForAutoLayout($0)
        }

        let insetInside: CGFloat = 10
        let insetVertical: CGFloat = 8
        NSLayoutConstraint.activate([
            ago.topAnchor.constraint(equalTo: banner.topAnchor, constant: insetInside),
            ago.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: insetInside),
            
            title.topAnchor.constraint(equalTo: ago.bottomAnchor, constant: insetVertical),
            title.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: insetInside),
            title.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: -insetInside),
            
            summary.topAnchor.constraint(equalTo: title.bottomAnchor, constant: insetVertical),
            summary.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: insetInside),
            summary.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: -insetInside),
            summary.bottomAnchor.constraint(equalTo: banner.bottomAnchor, constant: -insetInside)
        ])
    }

    func load(article: Article) {
        title.text = article.titleDisplay
        ago.text = article.ago?.uppercased()
        summary.text =  article.descriptionOrContent
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
    }

}
