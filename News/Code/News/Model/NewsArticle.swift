//
//  News.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import Foundation

struct NewsApiResponse: Codable {
    let status: String
    let totalResults: Int
    let results: [Article]
}

struct Article: Codable {
    let title: String?
    let link: String?
    let description: String?
    let creator: [String]?
    let pubDate: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case title, link, description, creator, pubDate
        case imageURL = "image_url"
    }
}
