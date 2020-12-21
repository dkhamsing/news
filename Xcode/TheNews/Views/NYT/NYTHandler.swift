//
//  Created by Daniel on 12/12/20.
//

import UIKit

class NYTHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NYTCell.identifier) as! NYTCell

        let article = articles[indexPath.row]
        cell.load(article: article, downloader: ImageDownloader.shared)

        //        downloader.getImage(imageUrlString: article.image) { (image, identifier) in
        //            if article.image == identifier,
        //               let image = image {
        //                let value = (tableView.bounds.size.width - (2 * NYTCell.inset)) * image.size.height / image.size.width
        //                cell.heightConstraint.constant = value
        //                cell.layoutIfNeeded()
        //
        //                cell.articleImageView.image = image
        //            }
        //        }

        return cell
    }

}
