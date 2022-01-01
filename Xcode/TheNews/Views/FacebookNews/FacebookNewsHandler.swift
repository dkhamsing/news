//
//  Created by Daniel on 12/23/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class FacebookNewsHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FacebookNewsCell.identifier) as! FacebookNewsCell

        let article = articles[indexPath.row]
        cell.load(article: article)

        return cell
    }

}
