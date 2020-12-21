//
//  Created by Daniel on 12/17/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class NBCNewsHandler: NewsTableHandler {

    var nbcItems: [Article] {
        guard articles.count > 0 else { return [] }
        return articles.suffix(articles.count-1)
    }

    var nbcHeaders: [Article] {
        guard let first = articles.first else { return [] }
        return [first]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count > 0 ? 2 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return nbcHeaders.count
        case 1:
            return nbcItems.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: NBCNewsCellLarge.identifier) as! NBCNewsCellLarge
            let article = nbcHeaders[indexPath.row]
            cell.load(article: article)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NBCNewsCell.identifier) as! NBCNewsCell
            let article = nbcItems[indexPath.row]
            cell.load(article: article, downloader: ImageDownloader.shared)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let item = nbcHeaders[indexPath.row]
            guard let url = item.url else { return }

            UIApplication.shared.open(url)
        case 1:
            let item = nbcItems[indexPath.row]
            guard let url = item.url else { return }

            UIApplication.shared.open(url)
        default:
            break
        }
    }

}
