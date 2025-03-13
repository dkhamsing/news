import UIKit

class EconomistHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EconomistCell.identifier) as! EconomistCell

        let article = articles[indexPath.row]
        cell.load(article: article)

        return cell
    }

}
