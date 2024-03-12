//
//  NewsView.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import SwiftUI

struct NewsView: View {
    @State private var articles: [Article] = []
    var keyword: String

    var body: some View {
        List(articles, id: \.url) { article in
            VStack(alignment: .leading) {
                Text(article.title).font(.headline)
                if let author = article.author, !author.isEmpty {
                    Text("By \(author)").font(.subheadline).foregroundColor(.secondary)
                }
                if let description = article.description, !description.isEmpty {
                    Text(description).font(.body)
                }
            }
        }
        .onAppear {
            Task {
                await loadNews()
            }
        }
    }

    private func loadNews() async {
        let query = NewsQuery(keyword: keyword, country: nil, category: nil)
        do {
            let fetchedNews = try await NewsManager().getCurrentNews(query: query)
            articles = fetchedNews.articles
        } catch {
            print("An error occurred: \(error)")
        }
    }
}

    
#Preview {
    NewsView(keyword: "apple")
}
