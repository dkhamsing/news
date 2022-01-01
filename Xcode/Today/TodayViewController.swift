//
//  TodayViewController.swift
//  Today
//
//  Created by Daniel on 5/19/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit
import NotificationCenter

private struct Constant {
    static let imageSize = CGSize(width: 100, height: 70)
}

class TodayViewController: UIViewController, NCWidgetProviding {

    @IBAction func actionButton(_ sender: Any) {
        guard let url = url else { return }

        self.extensionContext?.open(url, completionHandler: nil)
    }

    @IBOutlet var agoLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var imageView: UIImageView!

    private var url: URL?
    private var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setup()

        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        loadData(NewsCategory.general.rawValue)

        completionHandler(NCUpdateResult.newData)
    }

    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded

        let itemSize = article?.size(maxSize: maxSize, titleLabelFont: self.titleLabel.font, contentLabelFont: self.contentLabel.font)
        let defaultSize = CGSize(width: maxSize.width, height: 110)
        preferredContentSize = expanded ? itemSize ?? defaultSize : defaultSize

        contentLabel.isHidden = !expanded
    }

}

private extension TodayViewController {

    func loadData(_ category: String) {
        guard let url = NewsApi.urlForCategory(category) else { return }

        NewsApi.getArticles(url: url) { [weak self] (articles) in

            let article = articles?.first
            self?.article = article

            self?.url = article?.url

            let topText = "\(article?.ago ?? "") - \(article?.source?.name ?? "")"
            self?.agoLabel.text = topText

            self?.titleLabel.text = article?.title
            self?.contentLabel.text = article?.descriptionOrContent

            self?.imageView.load(urlString: article?.urlToImage, size: Constant.imageSize, downloader: ImageDownloader.shared)

        }
    }
}

private extension TodayViewController {
    func setup() {
        agoLabel.textColor = .secondaryLabel
        contentLabel.textColor = .secondaryLabel

        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
    }
}

private extension Article {
    func heightForMaxWidth(max: CGFloat, font: UIFont, contentLabelFont: UIFont) -> CGFloat {
        let topLabel = 15
        var t = Int(title?.heightForMaxWidth(width: max, font: font) ?? 0)

        let h = Int(Constant.imageSize.height)
        if t < h {
            let inset = 20
            t = h + inset
        }

        let content = Int(descriptionOrContent?.heightForMaxWidth(width: max, font: contentLabelFont) ?? 0)
        let padding = 10

        return CGFloat(topLabel + t + content + padding)
    }

    func size(maxSize: CGSize, titleLabelFont: UIFont, contentLabelFont: UIFont) -> CGSize {
        return CGSize(width: maxSize.width, height: heightForMaxWidth(max: maxSize.width, font: titleLabelFont, contentLabelFont: contentLabelFont))
    }
}

private extension String {
    func heightForMaxWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)

        return rect.height
    }
}
