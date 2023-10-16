import UIKit

class ThreadsCell: NewsCell {

    static let identifier: String = "ThreadsCell"
    private static let logoSize = CGSize(width: 34, height: 34)

    let author = UILabel()
    let container = UIView()
    let url = UILabel()

    override func config() {
        super.config()
        
        logo.layer.cornerRadius = ThreadsCell.logoSize.width / 2
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
                
        title.font = .preferredFont(forTextStyle: .subheadline)
        
        source.font = .preferredFont(forTextStyle: .subheadline)
      
        [logo, author, ago, summary, container].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 164
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset + 5),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.heightAnchor.constraint(equalToConstant: ThreadsCell.logoSize.height),
            logo.widthAnchor.constraint(equalToConstant: ThreadsCell.logoSize.width),

            author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            author.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),
            
            ago.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            ago.leadingAnchor.constraint(equalTo: author.trailingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: ago.trailingAnchor),

            summary.topAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset - 5),
            summary.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: summary.trailingAnchor),
            
            container.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: inset),
            container.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: inset + 5)
        ])
        
        [articleImageView, url, title].forEach {
            container.addSubviewForAutoLayout($0)
        }
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            articleImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            url.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset + 5),
            url.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: inset),
            url.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -inset),
            
            title.topAnchor.constraint(equalTo: url.bottomAnchor, constant: inset - 5),
            title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: inset),
            container.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),
            container.bottomAnchor.constraint(equalTo: title.bottomAnchor, constant: inset + 5)
        ])
    }

    func load(article: Article) {
        author.text = article.author ?? article.source?.name
        summary.text = article.description
        title.text = article.titleDisplay
        ago.text = article.ago
        url.text = article.url?.host?.replacingOccurrences(of: "www.", with: "")
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: ThreadsCell.logoSize)
    }

}
