import UIKit

class TapestryCell: NewsCell {

    static let identifier: String = "TapestryCell"
    private static let logoSize = CGSize(width: 42, height: 42)

    let author = UILabel()
    let container = UIView()
    let url = UILabel()

    override func config() {
        super.config()
        
        let mainColor = rand
        
        logo.layer.cornerRadius = TapestryCell.logoSize.width / 2
        logo.layer.masksToBounds = true
        
        author.font = .preferredFont(forTextStyle: .headline)
        
        ago.textColor = mainColor
        ago.font = .preferredFont(forTextStyle: .body)

        url.textColor = mainColor
        url.font = .boldSystemFont(ofSize: 13)
        
        container.layer.cornerRadius = 10
        container.layer.masksToBounds = true
        container.backgroundColor = mainColor.withAlphaComponent(0.3)
                
        title.font = .boldSystemFont(ofSize: 14)
        
        source.font = .preferredFont(forTextStyle: .headline)
        source.textColor = mainColor
        
        let containerView = UIView()
        containerView.backgroundColor = mainColor.withAlphaComponent(0.2)
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        contentView.addSubviewForAutoLayout(containerView)
        contentView.addSubviewForAutoLayout(logo)
      
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            logo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            logo.heightAnchor.constraint(equalToConstant: TapestryCell.logoSize.height),
            logo.widthAnchor.constraint(equalToConstant: TapestryCell.logoSize.width),
        ])
        
        let stripe = UIView()
        stripe.backgroundColor = source.textColor
        
        [stripe, source, author, ago, summary, container].forEach {
            containerView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 164
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            stripe.topAnchor.constraint(equalTo: containerView.topAnchor),
            stripe.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stripe.widthAnchor.constraint(equalToConstant: 10),
            
            source.topAnchor.constraint(equalTo: containerView.topAnchor, constant: inset + 5),
            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),
            
            author.topAnchor.constraint(equalTo: source.bottomAnchor),
            author.leadingAnchor.constraint(equalTo: source.leadingAnchor),
            
            ago.topAnchor.constraint(equalTo: source.topAnchor),
            ago.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -inset - 8),
            
            summary.topAnchor.constraint(equalTo: author.bottomAnchor, constant: inset - 5),
            summary.leadingAnchor.constraint(equalTo: source.leadingAnchor),
            summary.trailingAnchor.constraint(equalTo: ago.trailingAnchor),
            
            container.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: inset),
            container.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),
            container.trailingAnchor.constraint(equalTo: ago.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: inset + 5)
        ])
        
        [articleImageView, url, title].forEach {
            container.addSubviewForAutoLayout($0)
        }
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            articleImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            title.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset - 4),
            title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: inset),
            container.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),
            
            url.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            url.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: inset),
            url.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -inset),
            container.bottomAnchor.constraint(equalTo: url.bottomAnchor, constant: inset - 4)
        ])
    }
    
    var rand: UIColor {
        let colors: [UIColor] =  [
            .systemBlue,
            .systemGreen,
            .systemRed,
            .systemGray,
            .systemPink,
            .systemYellow,
            .systemOrange
        ]
        
        if let color = colors.randomElement() { return color }
        return .systemBlue
    }

    func load(article: Article) {
        author.text = article.author ?? article.source?.name
        summary.text = article.description
        title.text = article.titleDisplay
        ago.text = article.ago
        source.text = article.source?.name
        url.text = article.url?.host?.replacingOccurrences(of: "www.", with: "")
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: TapestryCell.logoSize)
    }

}
