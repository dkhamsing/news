//
//  InstagramHandler.swift
//  TheNews
//
//  Created by Daniel on 9/12/21.
//  Copyright © 2021 dk. All rights reserved.
//

import UIKit

class InstagramHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InstagramCell.identifier) as! InstagramCell

        let article = articles[indexPath.row]
        cell.load(article: article)

        return cell
    }

}
