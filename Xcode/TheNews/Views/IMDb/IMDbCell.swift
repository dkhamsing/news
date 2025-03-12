import UIKit

class IMDbCell: NewsCell {

    static let identifier: String = "IMDbCell"

    override func config() {
        super.config()
   
        title.font = .preferredFont(forTextStyle: .subheadline)
        title.numberOfLines = 3
        
        summary.font = title.font
        
        summary.textColor = .secondaryLabel
        summary.numberOfLines = 2
        
        source.font = .preferredFont(forTextStyle: .footnote)
        source.textColor = .secondaryLabel

        ago.textColor = .secondaryLabel
        ago.font = .preferredFont(forTextStyle: .footnote)

        [logo, title, source, ago, articleImageView, summary].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageWidth: CGFloat = 90
        let imageHeight: CGFloat = 130
        let inset: CGFloat = 8
        NSLayoutConstraint.activate([
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            ago.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset + 5),
            
            source.leadingAnchor.constraint(equalTo: ago.trailingAnchor, constant: inset),
            source.topAnchor.constraint(equalTo: ago.topAnchor),
            
            title.topAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset / 2),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
            
            summary.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            summary.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            summary.trailingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant: -inset),
                                    
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset + 5),
            articleImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset),
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            articleImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),
            
            contentView.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: inset + 5)
        ])

    }

    func load(article: Article) {
        title.text = article.titleDisplay
        summary.text = article.descriptionOrContent
        source.text = article.source?.name
        ago.text = article.ago
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
    }

}
