//
//  Created by Daniel on 12/12/20.
//

import UIKit

class UIKitHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UIKitCell.identifier) as! UIKitCell

        let article = articles[indexPath.row]
        cell.load(article: article)

        return cell
    }

}
