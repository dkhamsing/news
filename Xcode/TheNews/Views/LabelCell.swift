//
//  LabelCell.swift
//  TheNews
//
//  Created by Daniel on 4/14/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    private let name = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()

        name.text = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        config()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LabelCell {
    static var ReuseIdentifier: String = "LabelCell"

    func configure(_ string: String, _ same: Bool) {
        name.text = string
        contentView.backgroundColor = same ? .black : .gray
    }
}

extension LabelCell: Configurable {
    func setup() {
        name.textColor = .white
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 12)

        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
    }

    func config() {
        contentView.addSubviewForAutoLayout(name)

        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}
