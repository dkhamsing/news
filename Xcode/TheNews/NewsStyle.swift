//
//  NewsStyle.swift
//  TheNews
//
//  Created by Daniel on 5/20/20.
//  Copyright © 2020 dk. All rights reserved.
//

import Foundation

enum NewsStyle: String, CaseIterable, Codable {
    case bbc = "BBC"
    case cnn = "CNN"
    case facebook = "Facebook"
    case flipboard = "Flipboard"
    case reddit = "Reddit"
    case twitter = "Twitter"
    case nyt = "The New York Times"
    case wsj = "The Wall Street Journal"
    case washingtonPost = "The Washington Post"
    case lilnews = "Lil News"
}
