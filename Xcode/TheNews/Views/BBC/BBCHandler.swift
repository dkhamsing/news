//
//  Created by Daniel on 12/12/20.
//

import UIKit

class BBCHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BBCCell.identifier) as! BBCCell

        let article = articles[indexPath.row]
        cell.load(article: article, row: indexPath.row)

        return cell
    }

}
