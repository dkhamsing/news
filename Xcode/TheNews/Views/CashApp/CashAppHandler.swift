//
//  CashAppHandler.swift
//  TheNews
//
//  Created by Daniel on 12/28/21.
//  Copyright © 2021 dk. All rights reserved.
//

import UIKit

class CashAppHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CashAppCell.identifier) as! CashAppCell

        let article = articles[indexPath.row]
        cell.load(article: article)

        return cell
    }

}
