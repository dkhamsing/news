//
//  NewsApi.swift
//  TheNews
//
//  Created by Daniel on 4/10/20.
//  Copyright © 2020 dk. All rights reserved.
//

import Foundation

extension URL {
    func get<T: Codable>(type: T.Type, completion: @escaping (Result<T, ApiError>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: self) { data, _, error in
            if let _ = error {
                DispatchQueue.main.async {
                    completion(.failure(.generic))
                }
                return
            }

            guard let unwrapped = data else {
                DispatchQueue.main.async {
                    completion(.failure(.generic))
                }
                return
            }

            if let result = try? JSONDecoder().decode(type, from: unwrapped) {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(.failure(.generic))
                }
            }
        }

        task.resume()
    }
}

enum ApiError: Error {
    case generic
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .generic:
            return NSLocalizedString("Could not retrieve data.", comment: "")
        }
    }
}

struct Headline: Codable {
    var articles: [Article]
}

struct Article: Codable {
    var title: String?
    var description: String?
    var content: String?
    var url: URL?
    var urlToImage: String?
    var publishedAt: String?
    var source: Source?
}

struct Source: Codable {
    var name: String?
}

extension Article {
    var descriptionOrContent: String? {
        return description ?? content
    }

    var identifier: String? {
        return url?.absoluteString ?? urlToImage
    }
}

enum NewsCategory: String, CaseIterable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}
