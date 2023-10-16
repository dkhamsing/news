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
    var viewTable: UITableView!

    var handlerAppleNews = AppleNewsHandler()
    var handlerApollo = ApolloHandler()
    var handlerAxios = AxiosHandler()
    var handlerArtifact = ArtifactHandler()
    var handlerBBC = BBCHandler()
    var handlerCashApp = CashAppHandler()
    var handlerCNN = CNNHandler()
    var handlerFacebook = FacebookHandler()
    var handlerFacebookNews = FacebookNewsHandler()
    var handlerFastNews = FastNewsHandler()
    var handlerFlipboard = FlipboardHandler()
    var handlerInstagram = InstagramHandler()
    var handlerNBCNews = NBCNewsHandler()
    var handlerNYT = NYTHandler()
    var handlerReddit = RedditHandler()
    var handlerRobinhood = RobinhoodHandler()
    var handlerThreads = ThreadsHandler()
    var handlerTwitter = TwitterHandler()
    var handlerUIKit = UIKitHandler()
    var handlerWashingtonPost = WashingtonPostHandler()
    var handlerWSJ = WSJHandler()

    var viewCollection: UICollectionView!

    var handlerLilNews = LilNewsHandler()

    var viewModel: NewsViewModel!

    let downloader = ImageDownloader()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = NewsViewModel(controller: self)
        configure()
        viewModel.load()
    }

    func load(title thisTitle: String) {
        title = thisTitle
    }

    func load(articles: [Article]) {
        handlerAppleNews.articles = articles
        handlerApollo.articles = articles
        handlerArtifact.articles = articles
        handlerAxios.articles = articles
        handlerBBC.articles = articles
        handlerCashApp.articles = articles
        handlerCNN.articles = articles
        handlerFacebook.articles = articles
        handlerFacebookNews.articles = articles
        handlerFastNews.articles = articles
        handlerFlipboard.articles = articles
        handlerInstagram.articles = articles
        handlerLilNews.items = articles
        handlerNBCNews.articles = articles
        handlerNYT.articles = articles
        handlerReddit.articles = articles
        handlerRobinhood.articles = articles
        handlerThreads.articles = articles
        handlerTwitter.articles = articles
        handlerUIKit.articles = articles
        handlerWashingtonPost.articles = articles
        handlerWSJ.articles = articles
    }

    func load(_ style: NewsViewModel.Style) {
        updateVisibility(style)

        if style.isTable {
            updateTable(style)
        } else {
            updateCollection(style)
        }
    }

}

private extension NewsViewController {

    func configure() {
        view.backgroundColor = .systemGray6
        configureNavigation()
        configureViewTable()
        configureViewCollection()
    }

    func configureNavigation() {
        let styleImage = UIImage(systemName: "textformat.size")
        let styleBarbutton = UIBarButtonItem(title: nil, image: styleImage, primaryAction: nil, menu: viewModel.styleMenu)
        styleBarbutton.tintColor = .systemGray
        navigationItem.rightBarButtonItem = styleBarbutton

        let categoryImage = UIImage(systemName: "list.dash")
        let categoryBarButton = UIBarButtonItem(title: nil, image: categoryImage, primaryAction: nil, menu: viewModel.categoryMenu)
        categoryBarButton.tintColor = .systemGray
        navigationItem.leftBarButtonItem = categoryBarButton
    }

    func configureViewCollection() {
        let identifiers = NewsViewModel.Style.allCases
            .filter { !$0.isTable }
            .flatMap { $0.identifiers }
        viewCollection = UICollectionView(frame: .zero, direction: .horizontal, identifiers: identifiers)
        viewCollection.isHidden = true
        viewCollection.showsHorizontalScrollIndicator = false

        view.addSubviewForAutoLayout(viewCollection)
        NSLayoutConstraint.activate([
            viewCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func configureViewTable() {
        let identifiers = NewsViewModel.Style.allCases
            .filter { $0.isTable }
            .flatMap { $0.identifiers }
        viewTable = UITableView(frame: .zero, style: .plain, identifiers: identifiers)
        viewTable.isHidden = true
        viewTable.separatorInset = .zero
        viewTable.rowHeight = UITableView.automaticDimension
        viewTable.cellLayoutMarginsFollowReadableWidth = true

        view.addSubviewForAutoLayout(viewTable)
        NSLayoutConstraint.activate([
            viewTable.topAnchor.constraint(equalTo: view.topAnchor),
            viewTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func updateCollection(_ style: NewsViewModel.Style) {
        switch style {
        case .lilnews:
            viewCollection.dataSource = handlerLilNews
            viewCollection.delegate = handlerLilNews
        default:
            break
        }

        viewCollection.reloadData()
    }

    func updateTable(_ style: NewsViewModel.Style) {
        switch style {
        case .applenews:
            viewTable.dataSource = handlerAppleNews
            viewTable.delegate = handlerAppleNews
        case .apollo:
            viewTable.dataSource = handlerApollo
            viewTable.delegate = handlerApollo
        case .artifact:
            viewTable.dataSource = handlerArtifact
            viewTable.delegate = handlerArtifact
        case .axios:
            viewTable.dataSource = handlerAxios
            viewTable.delegate = handlerAxios
        case .bbc:
            viewTable.dataSource = handlerBBC
            viewTable.delegate = handlerBBC
        case .cashapp:
            viewTable.dataSource = handlerCashApp
            viewTable.delegate = handlerCashApp
        case .cnn:
            viewTable.dataSource = handlerCNN
            viewTable.delegate = handlerCNN
        case .facebook:
            viewTable.dataSource = handlerFacebook
            viewTable.delegate = handlerFacebook
        case .facebooknews:
            viewTable.dataSource = handlerFacebookNews
            viewTable.delegate = handlerFacebookNews
        case .fastnews:
            viewTable.dataSource = handlerFastNews
            viewTable.delegate = handlerFastNews
        case .flipboard:
            viewTable.dataSource = handlerFlipboard
            viewTable.delegate = handlerFlipboard
        case .instagram:
            viewTable.dataSource = handlerInstagram
            viewTable.delegate = handlerInstagram
        case .nbcnews:
            viewTable.dataSource = handlerNBCNews
            viewTable.delegate = handlerNBCNews
        case .thenyt:
            viewTable.dataSource = handlerNYT
            viewTable.delegate = handlerNYT
        case .reddit:
            viewTable.dataSource = handlerReddit
            viewTable.delegate = handlerReddit
        case .robinhood:
            viewTable.dataSource = handlerRobinhood
            viewTable.delegate = handlerRobinhood
        case .threads:
            viewTable.dataSource = handlerThreads
            viewTable.delegate = handlerThreads
        case .twitter:
            viewTable.dataSource = handlerTwitter
            viewTable.delegate = handlerTwitter
        case .uikit:
            viewTable.dataSource = handlerUIKit
            viewTable.delegate = handlerUIKit
        case .thewashingtonpost:
            viewTable.dataSource = handlerWashingtonPost
            viewTable.delegate = handlerWashingtonPost
        case .thewsj:
            viewTable.dataSource = handlerWSJ
            viewTable.delegate = handlerWSJ
        case .lilnews:
            break
        }

        viewTable.reloadData()

        guard viewTable.numberOfSections > 0,
              viewTable.numberOfRows(inSection: 0) > 0 else { return }

        viewTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }

    func updateVisibility(_ style: NewsViewModel.Style) {
        switch style {
        case .lilnews:
            viewCollection.isHidden = false
            viewTable.isHidden = true

            viewCollection.isPagingEnabled = true
        default:
            viewCollection.isHidden = true
            viewTable.isHidden = false
        }
    }

}
