//
//  NewsModel.swift
//  NewsApp
//
//  Created by Adam on 10/05/2023.
//

import Foundation

// MARK: - News
struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}

// MARK: - Source
struct Source: Codable {
    let id: ID?
    let name: String
}

enum ID: String, Codable {
    case arsTechnica = "ars-technica"
    case bbcNews = "bbc-news"
    case businessInsider = "business-insider"
    case engadget = "engadget"
    case googleNews = "google-news"
    case theVerge = "the-verge"
    case wired = "wired"
}
