//
//  RobinhoodHandler.swift
//  TheNews
//
//  Created by Daniel on 12/28/21.
//  Copyright © 2021 dk. All rights reserved.
//

import UIKit

class RobinhoodHandler: NewsTableHandler {

    var itemsTop: [Article] {
        guard let first = articles.first else { return [] }
        return [first]
    }

    var items: [Article] {
        guard articles.count > 0 else { return [] }
        return articles.suffix(articles.count-1)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count > 0 ? 2 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return itemsTop.count
        case 1:
            return items.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: RobinhoodCellLarge.identifier) as! RobinhoodCellLarge
            let article = itemsTop[indexPath.row]
            cell.load(article.rh)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: RobinhoodCell.identifier) as! RobinhoodCell
            let article = items[indexPath.row]
            cell.load(article.rh)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let item = itemsTop[indexPath.row]
            guard let url = item.url else { return }

            UIApplication.shared.open(url)
        case 1:
            let item = items[indexPath.row]
            guard let url = item.url else { return }

            UIApplication.shared.open(url)
        default:
            break
        }
    }

}

private extension Article {

    var rh: rhArticle {
        let fontSize: CGFloat = 16
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AppleSDGothicNeo-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)]
        return rhArticle(top: rhTop, title: NSAttributedString(string: titleDisplay, attributes: attributes), url: urlToImage)
    }

    var rhTop: NSAttributedString {
        let fontsize: CGFloat = 13
        let attr1: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AppleSDGothicNeo-Bold", size: fontsize) ?? UIFont.boldSystemFont(ofSize: fontsize) ]
        let at1 = NSMutableAttributedString(string: source?.name ?? "", attributes: attr1)
        let attr2: [NSAttributedString.Key: Any] = [.font: UIFont(name: "AppleSDGothicNeo-Light", size: fontsize) ?? UIFont.systemFont(ofSize: fontsize)]
        let at2 = NSMutableAttributedString(string: " " + (ago ?? ""), attributes: attr2)
        at1.append(at2)
        return at1
    }

}

struct rhArticle {
    var top: NSAttributedString
    var title: NSAttributedString
    var url: String?
}
