import UIKit

class EconomistCell: NewsCell {

    static let identifier: String = "EconomistCell"
    private static let logoSize = CGSize(width: 18, height: 18)

    let author = UILabel()

    override func config() {
        super.config()
        
        title.font = UIFont(name: "Georgia", size: 15)
        
        source.font = .boldSystemFont(ofSize: 12)
        source.textColor = .systemRed
        
        ago.font = .systemFont(ofSize: 13)

        [logo, title, author, source, ago, articleImageView].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let imageHeight: CGFloat = 72
        let imageWidth: CGFloat = 120
        let inset: CGFloat = 10
        NSLayoutConstraint.activate([
            source.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset + 5),
            source.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),

            title.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor),
                                    
            articleImageView.topAnchor.constraint(equalTo: source.topAnchor),
            articleImageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: inset * 2), 
            articleImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            articleImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            contentView.readableContentGuide.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor),

            ago.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 22),
            ago.leadingAnchor.constraint(equalTo: contentView.readableContentGuide.leadingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: ago.bottomAnchor, constant: inset + 5)
        ])

    }

    func load(article: Article) {
        title.text = article.titleDisplay
        source.text = article.source?.name
        ago.text = article.ago
        load(urlString: article.urlToImage, downloader: ImageDownloader.shared)
    }

}
