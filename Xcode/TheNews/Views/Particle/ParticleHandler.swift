import UIKit

class ParticleHandler: NewsTableHandler {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ParticleCell.identifier) as! ParticleCell

        let article = articles[indexPath.row]
        cell.load(article: article)

        return cell
    }

}
