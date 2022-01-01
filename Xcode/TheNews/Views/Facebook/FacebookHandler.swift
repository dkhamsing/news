//
//  Created by Daniel on 12/13/20.
//

import UIKit

class FacebookHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FacebookCell.identifier) as! FacebookCell

        let article = articles[indexPath.row]
        cell.load(article: article)

        return cell
    }

}
