//
//  Created by Daniel on 12/19/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class AppleNewsHandler: NewsTableHandler {

    var itemsTop: [Article] {
        guard let first = articles.first else { return [] }
        return [first]
    }

    var itemsStacked: [Article] {
        guard articles.count > 3 else { return [] }

        let items = articles.suffix(articles.count-1)

        let pref = items.prefix(2)
        return Array(pref)
    }

    var items: [Article] {
        guard articles.count > 0 else { return [] }
        return articles.suffix(articles.count-3)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count > 0 ? 3 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return itemsTop.count
        case 1:
            return 1
        case 2:
            return items.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AppleNewsCellLarge.identifier) as! AppleNewsCellLarge
            let article = itemsTop[indexPath.row]
            cell.load(article: article)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: AppleNewsCellStacked.identifier) as! AppleNewsCellStacked
            cell.load(itemsStacked)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: AppleNewsCell.identifier) as! AppleNewsCell
            let article = items[indexPath.row]
            cell.load(article: article)
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
            print("todo!")
        case 2:
            let item = items[indexPath.row]
            guard let url = item.url else { return }

            UIApplication.shared.open(url)
        default:
            break
        }
    }

}
