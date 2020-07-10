//
//  InsetLabel.swift
//
//  Created by Daniel on 5/23/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

final class InsetLabel: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var label: UILabel!

    var text: String? {
        didSet {
            label.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        config()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        config()
    }

}

private extension InsetLabel {

    func config() {
        let nib = UINib(nibName: "InsetLabel", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)

        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
}
