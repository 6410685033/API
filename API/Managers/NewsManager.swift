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
        let query = getParam(query: query)
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?\(query)&apiKey=\(apiKey)")
        else {
            fatalError("Missing URL") // guard, else
        }
        
        let urlRequest = URLRequest(url: url) // create URL Request
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        } // as? => cast
        let decodeData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
        return decodeData
    }
    
    private func getParam(query: NewsQuery? = nil) -> String {
        var queryParams: [String] = []
        
        if let keyword = query?.keyword, !keyword.isEmpty {
                queryParams.append("q=\(keyword)")
            }
            
            if let country = query?.country, !country.isEmpty {
                queryParams.append("country=\(country)")
            }
            
            if let category = query?.category, !category.isEmpty {
                queryParams.append("category=\(category)")
            }
        
        let fullQueryString = queryParams.joined(separator: "&")
        return fullQueryString
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
