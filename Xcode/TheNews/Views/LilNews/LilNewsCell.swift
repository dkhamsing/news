//
//  Created by Daniel on 12/13/20.
//

import UIKit

class LilNewsCell: UICollectionViewCell {

    static let identifier = "LilNewsCell"

    var imageView: UIImageView = UIImageView()

    var title = UILabel()
    var ago = UILabel()
    var summary = UILabel()
    var source = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
    }

    func build() {
        imageView.backgroundColor = .systemFill
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        title.numberOfLines = 0
        title.textColor = .white
        title.font = .preferredFont(forTextStyle: .largeTitle)

        ago.textColor = .systemGray
        ago.font = .preferredFont(forTextStyle: .subheadline)

        summary.numberOfLines = 0
        summary.textColor = .systemGray2
        summary.font = .preferredFont(forTextStyle: .body)

        source.textColor = .white

        [imageView, title, ago, summary, source].forEach {
            contentView.addSubviewForAutoLayout($0)
        }

        let inset: CGFloat = 15
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            ago.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: ago.bottomAnchor),

            summary.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            summary.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            ago.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 10),

            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            summary.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),

            source.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            title.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 5)
        ])
    }

    func load(article: Article, downloader: ImageDownloader) {
        title.text = article.titleDisplay
        ago.text = article.ago
        summary.text = article.description
        source.text = article.source?.name

        contentView.addGradient(count: 5, index: 1)

        imageView.load(urlString: article.urlToImage, downloader: downloader)
    }

}
