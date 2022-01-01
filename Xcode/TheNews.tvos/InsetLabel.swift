//
//  InsetLabel.swift
//  TheNews.tvos
//
//  Created by Daniel on 4/28/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class InsetLabel: UIView {
    var label = UILabel()

    required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

    override init(frame: CGRect) {
        super.init(frame: frame)

          config()
      }
}

extension InsetLabel {

    func config() {
        self.addSubviewForAutoLayout(label)

        let inset: CGFloat = 20
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            self.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: inset),
            self.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: inset)
        ])
    }

}
