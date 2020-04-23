//
//  NewsViewController.swift
//  TheNews
//
//  Created by Daniel on 4/10/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController {
    // Data
    private var items: [Article] = []
    private let downloader = ImageDownloader()
    private var settings = Configuration()

    // UI
    private var collectionView: UICollectionView?
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        config()
        loadData(settings.category.rawValue)
    }
}

extension NewsViewController: Configurable {
    func setup() {
        // Settings
        settings.loadSaved()

        // Refresh control
        refreshControl.addTarget(self, action: #selector(loadDataForCurrentCategory), for: UIControl.Event.valueChanged)

        // Navigation item
        let styleImage = UIImage(systemName: "textformat.size")
        let styleBarbutton = UIBarButtonItem(image: styleImage, style: .plain, target: self, action: #selector(selectStyle))
        styleBarbutton.tintColor = .black
        navigationItem.rightBarButtonItems = [styleBarbutton]

        // Collection view
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: listInsetLayout())
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = .white
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.registerCells()
    }

    func config() {
        // Refresh control
        collectionView?.addSubview(refreshControl)

        // Collection view
        guard let cv = collectionView else { return }

        view.autolayoutAddSubview(cv)
    }
}

private extension NewsViewController {
    func loadData(_ category: String) {
        title = "\(settings.category.rawValue.capitalizingFirstLetter()) News"

        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(Configuration.ApiKey)&category=\(category)") else {
            print("error")
            return
        }

        items = []
        collectionView?.reloadData()

        url.get(type: Headline.self) { [weak self] (result) in
            self?.refreshControl.endRefreshing()

            switch result {
            case .success(let headline):
                self?.items = headline.articles
                self?.reload()

            case .failure(let e):
                print(e.localizedDescription)
            }
        }
    }
}

extension NewsViewController: Selectable {
    func didSelect(_ category: String) {
        loadData(category)

        guard let c = NewsCategory(rawValue: category) else { return }
        
        settings.category = c
    }
}

// MARK: - Collection view
extension NewsViewController: UICollectionViewDataSource {
    enum Section: Int, CaseIterable {
        case categories
        case articles
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }

        switch section {
        case .articles:
            return items.count
        default:
            return NewsCategory.allCases.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return NytCell() }

        switch section {
        case .articles:
            let article = items[indexPath.row]
            let identifier = article.identifier

            switch settings.style {
            case .flipboard:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlipboardCell.ReuseIdentifier, for: indexPath) as! FlipboardCell
                cell.configure(article)

                downloader.getImage(imageUrl: article.urlToImage, size: FlipboardCell.ImageSize) { (image) in
                    cell.update(image: image, identifier: identifier)
                }

                return cell

            case .lilnews:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LilCell.ReuseIdentifier, for: indexPath) as! LilCell
                cell.configure(article)

                downloader.getImage(imageUrl: article.urlToImage, size: CnnCell.ImageSize) { (image) in
                    cell.update(image: image, identifier: identifier)
                }

                return cell

            case .cnn:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CnnCell.ReuseIdentifier, for: indexPath) as! CnnCell
                cell.configure(article)

                downloader.getImage(imageUrl: article.urlToImage, size: CnnCell.ImageSize) { (image) in
                    cell.update(image: image, identifier: identifier)
                }

                return cell

            case .reddit:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RedditCell.ReuseIdentifier, for: indexPath) as! RedditCell
                cell.configure(article)

                downloader.getImage(imageUrl: article.urlToImage, size: RedditCell.ImageSize) { (image) in
                    guard cell.identifier == identifier else { return }
                    cell.update(image: image, identifier: identifier)
                }

                return cell

            case .bbc:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BbcCell.ReuseIdentifier, for: indexPath) as! BbcCell
                cell.configure(article)
                cell.configure(badgeNumber: indexPath.row + 1)
                downloader.getImage(imageUrl: article.urlToImage, size: BbcCell.ImageSize) { (image) in
                    guard cell.identifier == identifier else { return }
                    cell.update(image: image, identifier: identifier)
                }

                return cell

            case .nyt:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NytCell.ReuseIdentifier, for: indexPath) as! NytCell
                cell.configure(article)
                downloader.getImage(imageUrl: article.urlToImage, size: NytCell.ImageSize) { (image) in
                    guard cell.identifier == identifier else { return }
                    cell.update(image: image, identifier: identifier)
                }

                return cell

            case .twitter:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TwitterCell.ReuseIdentifier, for: indexPath) as! TwitterCell
                cell.configure(article)
                downloader.getImage(imageUrl: article.urlToImage, size: TwitterCell.ImageSize) { (image) in
                    guard cell.identifier == identifier else { return }
                    cell.update(image: image, identifier: identifier)
                }

                return cell

            case .facebook:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FacebookCell.ReuseIdentifier, for: indexPath) as! FacebookCell
                cell.configure(article)
                downloader.getImage(imageUrl: article.urlToImage, size: FacebookCell.ImageSize) { (image) in
                    guard cell.identifier == identifier else { return }
                    cell.update(image: image, identifier: identifier)
                }

                return cell
            }

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.ReuseIdentifier, for: indexPath) as! LabelCell

            let name = NewsCategory.allCases[indexPath.row].rawValue.capitalizingFirstLetter()
            cell.configure(name, settings.category.rawValue == name.lowercased())

            return cell
        }
    }
}

extension NewsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let section = Section(rawValue: indexPath.section) else { return }
        
        switch section {
        case .articles:
            let article = items[indexPath.row]
            guard let url = article.url else { return }

            let sfvc = SFSafariViewController(url: url)
            self.present(sfvc, animated: true, completion: nil)

        default:
            let categories = NewsCategory.allCases
            let c = categories[indexPath.row]

            settings.category = c
            loadData(c.rawValue)
        }
    }
}

// MARK: - Layout
private extension NewsViewController {
    func reload() {
        updateLayout(settings.style)

        collectionView?.reloadData()

        let topIndexPath = IndexPath(row: 0, section: 0)
        collectionView?.scrollToItem(at: topIndexPath, at: .top, animated: false)
    }

    func updateLayout(_ style: Style) {
        switch style {
        case .lilnews:
            collectionView?.backgroundColor = .white
            view.backgroundColor = .white
            collectionView?.collectionViewLayout = imageLayout()

        case .reddit, .flipboard:
            collectionView?.backgroundColor = .newsLightGray
            view.backgroundColor = .newsLightGray
            collectionView?.collectionViewLayout = listFullWidthLayout()

        case .bbc:
            collectionView?.backgroundColor = .newsLightGray
            view.backgroundColor = .newsLightGray
            collectionView?.collectionViewLayout = listInsetLayout()

        default:
            collectionView?.backgroundColor = .white
            view.backgroundColor = .white
            collectionView?.collectionViewLayout = listFullWidthLayout()
        }
    }

    func imageLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            switch Section(rawValue: sectionNumber) {
            case .articles:
                return self.imageSection()
            default:
                return self.categoriesSection()
            }
        }
    }

    func listFullWidthLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            switch Section(rawValue: sectionNumber) {
            case .articles:
                return self.listFullWidthSection()
            default:
                return self.categoriesSection()
            }
        }
    }

    func listInsetLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
            switch Section(rawValue: sectionNumber) {
            case .articles:
                return self.listInsetSection()
            default:
                return self.categoriesSection()
            }
        }
    }

    private func categoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.05))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }

    func imageSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.fractionalHeight(0.895)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        return section
    }

    func listFullWidthSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(400)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10

        return section
    }

    func listInsetSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.absolute(BbcCell.ImageSize.height)
        )
        let item = NSCollectionLayoutItem(layoutSize: size)

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10

        return section
    }
}

// MARK: - OBJC
private extension NewsViewController {
    @objc func loadDataForCurrentCategory() {
        loadData(settings.category.rawValue)
    }

    @objc func selectStyle() {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.fixiOSAutolayoutNegativeConstraints()

        for s in Style.allCases {
            ac.addAction(UIAlertAction(title: s.rawValue, style: .default, handler: handleStyle))
        }

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(ac, animated: true, completion: nil)
    }

    func handleStyle(_ action: UIAlertAction) {
        guard let selected = action.title else { return }

        let styles = Style.allCases
        let f = styles.filter { $0.rawValue == selected }
        guard let s = f.first else { return }

        settings.style = s
        reload()
    }
}

enum Style: String, CaseIterable {
    case bbc = "BBC"
    case cnn = "CNN"
    case facebook = "Facebook"
    case flipboard = "Flipboard"
    case lilnews = "Lil News"
    case nyt = "NYT"
    case reddit = "Reddit"
    case twitter = "Twitter"
}

private extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

private extension UICollectionView {
    func registerCells() {
        register(LabelCell.self, forCellWithReuseIdentifier: LabelCell.ReuseIdentifier)

        register(TwitterCell.self, forCellWithReuseIdentifier: TwitterCell.ReuseIdentifier)
        register(FacebookCell.self, forCellWithReuseIdentifier: FacebookCell.ReuseIdentifier)
        register(NytCell.self, forCellWithReuseIdentifier: NytCell.ReuseIdentifier)
        register(BbcCell.self, forCellWithReuseIdentifier: BbcCell.ReuseIdentifier)
        register(RedditCell.self, forCellWithReuseIdentifier: RedditCell.ReuseIdentifier)
        register(CnnCell.self, forCellWithReuseIdentifier: CnnCell.ReuseIdentifier)
        register(LilCell.self, forCellWithReuseIdentifier: LilCell.ReuseIdentifier)
        register(FlipboardCell.self, forCellWithReuseIdentifier: FlipboardCell.ReuseIdentifier)
    }
}

private extension UIColor {
    static let newsLightGray = UIColor.colorFor(red: 228, green: 229, blue: 230)
}
