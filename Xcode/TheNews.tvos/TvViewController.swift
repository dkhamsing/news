//
//  FirstViewController.swift
//  TheNews.tvos
//
//  Created by Daniel on 4/26/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class TvViewController: UIViewController {
    var category: NewsCategory = .general

    // UI
    private let tableView = UITableView()
    private let backgroundImageView = UIImageView()
    private let content = InsetLabel()
    private let qrImageView = UIImageView()

    // Date
    private var items: [Article] = []

    convenience init(_ category: NewsCategory) {
        self.init()

        self.category = category
        self.tabBarItem.title = category.rawValue.capitalized
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setup()
        config()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadData(category.rawValue)
    }
}

extension TvViewController {
    func setup() {
        content.label.numberOfLines = 0
        content.label.textColor = .black
        content.backgroundColor = .lightGray
        content.alpha = 0
        content.addTvCornerRadius()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TvNewsCell.self, forCellReuseIdentifier: TvNewsCell.identifier)

        qrImageView.layer.cornerRadius = 6
        qrImageView.layer.masksToBounds = true
    }

    func config() {
        // Image
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)

        backgroundImageView.addGradientLeftRight()

        // Table
        view.addSubviewForAutoLayout(tableView)
        let tableWidth = view.bounds.size.width / 3
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            tableView.widthAnchor.constraint(equalToConstant: tableWidth)
        ])

        // Content, QR code
        view.addSubviewForAutoLayout(content)
        view.addSubviewForAutoLayout(qrImageView)
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 75),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            qrImageView.leadingAnchor.constraint(equalTo: content.trailingAnchor, constant: 40),

            qrImageView.heightAnchor.constraint(equalToConstant: 200),
            qrImageView.widthAnchor.constraint(equalToConstant: 200),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: qrImageView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: qrImageView.bottomAnchor)
        ])
    }
}

extension TvViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]

        let c = tableView.dequeueReusableCell(withIdentifier: TvNewsCell.identifier) as! TvNewsCell

        c.configure(item)
        c.configureLogo(urlString: item.urlToSourceLogo)

        return c
    }
}

extension TvViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // TODO: prevent issue of image updating when fast scrolling
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        context.previouslyFocusedView?.backgroundColor = .clear
        context.nextFocusedView?.backgroundColor = .systemGray

        guard let indexPath = context.nextFocusedIndexPath else { return }

        let item = items[indexPath.row]
        update(item)
    }
}

private extension TvViewController {
    func loadData(_ category: String) {
        guard let url = NewsApi.urlForCategory(category) else {
            print("load data error")
            return
        }

        NewsApi.getArticles(url: url) { [weak self] (articles) in
            guard let articles = articles else { return }

            self?.items = articles
            self?.tableView.reloadData()

            guard let item = articles.first else { return }

            self?.updateImage(url: item.urlToImage)
        }
    }

    func update(_ item: Article) {
        updateImage(url: item.urlToImage)

        content.alpha = 0.6
        content.label.text = item.descriptionOrContent

        guard let ciImage = item.url?.qrImage else { return }

        let image = UIImage(ciImage: ciImage)
        qrImageView.image = image
    }

    func updateImage(url: String?) {
        backgroundImageView.load(urlString: url, size: view.bounds.size, downloader: ImageDownloader.shared)
    }
}
