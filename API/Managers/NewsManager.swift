//
//  NewsManager.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import Foundation

class NewsManager {
    private let apiKey = "0147ef302f4d4e15a04391b525c8c063"
    
    func getCurrentNews(query: NewsQuery? = nil) async throws -> ResponseBody {
        let queryParam = getParam(query: query ?? NewsQuery())
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?\(queryParam)&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(ResponseBody.self, from: data)
    }
    
    private func getParam(query: NewsQuery) -> String {
        var queryParams: [String] = []
        if let keyword = query.keyword, !keyword.isEmpty { queryParams.append("q=\(keyword)") }
        if let country = query.country, !country.isEmpty { queryParams.append("country=\(country)") }
        if let category = query.category, !category.isEmpty { queryParams.append("category=\(category)") }
        return queryParams.joined(separator: "&")
    }

}

struct NewsQuery {
    var keyword: String?
    var country: String?
    var category: String?
}


// Model of the response body we get from calling the News API
struct ResponseBody: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
