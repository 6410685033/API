//
//  NewsManager.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import Foundation

class NewsManager: ObservableObject {
    private let apiKey = "0147ef302f4d4e15a04391b525c8c063"
    @Published var isLoading = false
    @Published var news: ResponseBody?
    
    func getCurrentNews(keyword: String) async throws -> ResponseBody {
        isLoading = true
        
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://newsapi.org/v2/top-headlines?q=\(encodedKeyword)&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        isLoading = false
        return try JSONDecoder().decode(ResponseBody.self, from: data)
    }
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
