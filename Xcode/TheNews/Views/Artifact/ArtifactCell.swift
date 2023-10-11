import UIKit

class ArtifactCell: NewsCell {

    static let identifier: String = "ArtifactCell"
    private static let logoSize = CGSize(width: 18, height: 18)

    let author = UILabel()

    override func config() {
        super.config()
        
        logo.layer.cornerRadius = 5
        logo.layer.masksToBounds = true
        
        articleImageView.layer.cornerRadius = 8
        articleImageView.layer.masksToBounds = true
        
        title.font = .preferredFont(forTextStyle: .headline)

        author.font = .preferredFont(forTextStyle: .footnote)
        
        source.font = .preferredFont(forTextStyle: .footnote)

        ago.textColor = .secondaryLabel
        ago.font = .preferredFont(forTextStyle: .footnote)

        [logo, title, author, source, ago, articleImageView].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 70
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset + 5),
            logo.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            logo.heightAnchor.constraint(equalToConstant: ArtifactCell.logoSize.height),
            logo.widthAnchor.constraint(equalToConstant: ArtifactCell.logoSize.width),

            source.centerYAnchor.constraint(equalTo: logo.centerYAnchor, constant: 0),
            source.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: inset - 2),
            
            ago.centerYAnchor.constraint(equalTo: logo.centerYAnchor, constant: 0),
            ago.leadingAnchor.constraint(equalTo: source.trailingAnchor, constant: inset - 2),

            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: inset / 2),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
                                    
            articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),
            articleImageView.leadingAnchor.constraint(equalTo: author.trailingAnchor, constant: inset),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            articleImageView.widthAnchor.constraint(equalToConstant: imageHeight),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),

            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: inset / 2),
            author.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: author.bottomAnchor, constant: inset + 5)
        ])

    }

    func load(article: Article) {
        title.text = article.titleDisplay
        source.text = article.source?.name
        ago.text = article.ago
        author.attributedText = article.attributedAuthor
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
        loadLogo(urlString: article.urlToSourceLogo, size: ArtifactCell.logoSize)
    }

}

private extension Article {
    
    var attributedAuthor: NSAttributedString? {
        guard let authors = author else { return nil }
        
        let att = NSMutableAttributedString(string: "by ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.secondaryLabel])
        att.append(NSAttributedString(string: authors))
        return att
    }
    
}
