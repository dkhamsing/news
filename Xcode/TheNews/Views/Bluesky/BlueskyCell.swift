import UIKit

class BlueskyCell: NewsCell {

    static let identifier: String = "BlueskyCell"
    private static let logoSize = CGSize(width: 34, height: 34)

    let author = UILabel()
    let container = UIView()
    let url = UILabel()

    override func config() {
        super.config()
        
        logo.layer.cornerRadius = BlueskyCell.logoSize.width / 2
        logo.layer.masksToBounds = true
        
        author.font = .preferredFont(forTextStyle: .headline)
        
        ago.textColor = .secondaryLabel
        ago.font = .preferredFont(forTextStyle: .body)

        url.textColor = .secondaryLabel
        url.font = .preferredFont(forTextStyle: .footnote)
        
        container.layer.borderColor = UIColor.quaternaryLabel.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 10
        container.layer.masksToBounds = true
                
        title.font = .preferredFont(forTextStyle: .headline)
      
        [logo, author, ago, summary, container].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 164
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset + 5),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.heightAnchor.constraint(equalToConstant: BlueskyCell.logoSize.height),
            logo.widthAnchor.constraint(equalToConstant: BlueskyCell.logoSize.width),

            author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            author.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),
            
            ago.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            ago.leadingAnchor.constraint(equalTo: author.trailingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: ago.trailingAnchor, constant: inset + 8),
            
            summary.topAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset - 5),
            summary.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor),
            
            container.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: inset),
            container.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: inset + 5)
        ])
        
        let separatorView = UIView()
        separatorView.backgroundColor = .quaternaryLabel
        
        let iconSize: CGFloat = 13
        let icon = UIImageView()
        
        if let img = UIImage(systemName: "globe.asia.australia"),
           let globeImage: UIImage = img
            .applyingSymbolConfiguration(.init(
                font: .systemFont(ofSize: iconSize),
                scale: .default)) {
            icon.image = globeImage
            icon.tintColor = .secondaryLabel
        }
        
        [articleImageView, url, title, separatorView, icon].forEach {
            container.addSubviewForAutoLayout($0)
        }
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            articleImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            title.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            
            separatorView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: inset),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 10),
            
            icon.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: inset + 1),
            icon.heightAnchor.constraint(equalToConstant: iconSize),
            icon.widthAnchor.constraint(equalToConstant: iconSize),
            icon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: inset),
            
            url.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: inset),
            url.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 4),
            url.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -inset),
            
            container.bottomAnchor.constraint(equalTo: url.bottomAnchor, constant: inset)
        ])
    }

    func load(article: Article) {
        author.text = article.author ?? article.source?.name
        summary.text = article.description
        title.text = article.titleDisplay
        ago.text = article.ago
        url.text = article.url?.host?.replacingOccurrences(of: "www.", with: "")
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: BlueskyCell.logoSize)
    }

}
