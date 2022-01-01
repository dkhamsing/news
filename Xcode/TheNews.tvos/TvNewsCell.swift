//
//  TvNewsCell.swift
//  TheNews.tvos
//
//  Created by Daniel on 4/27/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class TvNewsCell: UITableViewCell {
    static let identifier = "TvNewsCell"
    private static let logoSize = CGSize(width: 50, height: 50)

    private var tvTitle = UILabel()
    private var tvLogo = UIImageView()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
        config()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        tvLogo.image = nil
        tvTitle.text = nil
    }
}

extension TvNewsCell {
    func configure(_ item: Article) {
        tvTitle.text = item.titleDisplay
    }

    func configureLogo(urlString: String?) {
        tvLogo.load(urlString: urlString, size: TvNewsCell.logoSize, downloader: ImageDownloader.shared)
    }
}

extension TvNewsCell {
    func setup() {
        focusStyle = .custom

        self.addTvCornerRadius()

        tvLogo.layer.cornerRadius = TvNewsCell.logoSize.height/2
        tvLogo.layer.masksToBounds = true

        tvTitle.numberOfLines = 0
        tvTitle.textColor = .white
    }

    func config() {
        contentView.addSubviewForAutoLayout(tvTitle)
        contentView.addSubviewForAutoLayout(tvLogo)

        let inset: CGFloat = 20
        NSLayoutConstraint.activate([
            tvTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            tvTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            contentView.trailingAnchor.constraint(equalTo: tvTitle.trailingAnchor, constant: inset),

            tvLogo.topAnchor.constraint(equalTo: tvTitle.bottomAnchor, constant: inset),
            tvLogo.leadingAnchor.constraint(equalTo: tvTitle.leadingAnchor),
            tvLogo.widthAnchor.constraint(equalToConstant: TvNewsCell.logoSize.width),
            contentView.bottomAnchor.constraint(equalTo: tvLogo.bottomAnchor, constant: inset),
            tvLogo.heightAnchor.constraint(equalToConstant: TvNewsCell.logoSize.height)
        ])
    }
}
