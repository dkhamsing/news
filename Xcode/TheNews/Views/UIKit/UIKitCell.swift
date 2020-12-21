//
//  Created by Daniel on 12/12/20.
//

import UIKit

class UIKitCell: UITableViewCell {

    static let identifier = "UIKitCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func build() {
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.textColor = .secondaryLabel
    }

    func load(article: Article) {
        textLabel?.text = article.title
        detailTextLabel?.text = article.description
    }

}
