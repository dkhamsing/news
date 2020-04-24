//
//  NewsProfileCell.swift
//  TheNews
//
//  Created by Daniel on 4/22/20.
//  Copyright © 2020 dk. All rights reserved.
//

import UIKit

class NewsProfileCell: NewsCell {
    let sourceLogo = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sourceLogo.image = nil
    }
    
    func updateSourceLogo(image: UIImage?, matchingIdentifier: String?) {
        guard identifier == matchingIdentifier else { return }

        sourceLogo.image = image
    }
}
