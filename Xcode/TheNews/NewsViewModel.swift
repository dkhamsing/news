//
//  Created by Daniel on 12/12/20.
//

import UIKit

class NewsViewModel {

    var controller: NewsViewController

    var style: Style = Settings.shared.style

    var categoryName: String = ""

    init(controller: NewsViewController) {
        self.controller = controller
    }

    func load() {
        loadArticles()
        controller.load(style)
    }

    func loadArticles(category: String = Settings.shared.category.rawValue) {
        let url = NewsApi.urlForCategory(category)
        NewsApi.getArticles(url: url) { [weak self] (articles) in
            guard let articles = articles,
                  let style = self?.style else { return }
            self?.controller.load(articles: articles)
            self?.controller.load(style)
        }

        categoryName = category.capitalized

        let title = style.display + " - " + categoryName
        controller.load(title: title)
    }

    func select(_ category: String) {
        loadArticles(category: category)

        guard let newsCategory = NewsCategory(rawValue: category) else { return }
        Settings.shared.category = newsCategory
    }

    func select(_ aStyle: Style) {
        style = aStyle
        controller.load(style)

        let title = style.display + " - " + categoryName
        controller.load(title: title)

        Settings.shared.style = style
    }

    var categoryMenu: UIMenu {
        let menuActions = NewsCategory.allCases.map({ (item) -> UIAction in
            let name = item.rawValue
            return UIAction(title: name.capitalized, image: UIImage(systemName: item.systemName)) { (_) in
                self.select(name)
            }
        })

        return UIMenu(title: "Change Category", children: menuActions)
    }

    var styleMenu: UIMenu {
        let menuActions = NewsViewModel.Style.allCases.map { (style) -> UIAction in
            return UIAction(title: style.display, image: nil) { (_) in
                self.select(style)
            }
        }

        return UIMenu(title: "Change Style", children: menuActions)
    }

    enum Style: String, CaseIterable, Codable {

        case apollo,
             applenews,
             artifact,
             axios,
             bbc,
             cashapp,
             cnn,
             facebook,
             facebooknews,
             fastnews,
             flipboard,
             instagram,
             lilnews,
             nbcnews,
             reddit,
             robinhood,
             thenyt,
             thewashingtonpost,
             thewsj,
             threads,
             twitter,
             uikit

        var display: String {
            switch self {
            case .applenews:
                return "Apple News"
            case .cashapp:
                return "Cash App"
            case .facebooknews:
                return "Facebook News"
            case .fastnews:
                return "FastNews"
            case .lilnews:
                return "lil news"
            case .nbcnews:
                return "NBC News"
            case .twitter:
                return "Twitter"
            case .thenyt:
                return "The New York Times"
            case .thewashingtonpost:
                return "The Washington Post"
            case .thewsj:
                return "The Wall Street Journal"
            case .uikit:
                return "UIKit"
            case .bbc, .cnn:
                return self.rawValue.uppercased()
            case .apollo, .artifact, .axios, .facebook, .flipboard, .instagram, .reddit, .robinhood, .threads:
                return self.rawValue.capitalized
            }
        }

        var isTable: Bool {
            switch self {
            case .lilnews:
                return false
            default:
                return true
            }
        }

        var identifiers: [String] {
            switch self {
            case .apollo:
                return [ApolloCell.identifier]
            case .applenews:
                return [AppleNewsCellLarge.identifier, AppleNewsCell.identifier, AppleNewsCellStacked.identifier]
            case .artifact:
                return [ArtifactCell.identifier]
            case .axios:
                return [AxiosCell.identifier]
            case .bbc:
                return [BBCCell.identifier]
            case .cashapp:
                return [CashAppCell.identifier]
            case .cnn:
                return [CNNCell.identifier]
            case .facebook:
                return [FacebookCell.identifier]
            case .facebooknews:
                return [FacebookNewsCell.identifier]
            case .fastnews:
                return [FastNewsCell.identifier]
            case .flipboard:
                return [FlipboardCell.identifier]
            case .instagram:
                return [InstagramCell.identifier]
            case .lilnews:
                return [LilNewsCell.identifier]
            case .nbcnews:
                return [NBCNewsCell.identifier, NBCNewsCellLarge.identifier]
            case .thenyt:
                return [NYTCell.identifier]
            case .reddit:
                return [RedditCell.identifier]
            case .robinhood:
                return [RobinhoodCell.identifier, RobinhoodCellLarge.identifier]
            case .threads:                
                return [ThreadsCell.identifier]
            case .twitter:
                return [TwitterCell.identifier]
            case .uikit:
                return [UIKitCell.identifier]
            case .thewashingtonpost:
                return [WashingtonPostCell.identifier]
            case .thewsj:
                return [WSJCell.identifier]
            }
        }

    }

}
