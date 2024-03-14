//
//  NewsView.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import SwiftUI

struct NewsView: View {
    @State var news: ResponseBody?
    @State var newsManager = NewsManager()
    @State private var keyword: String = ""
    
    var body: some View {
        if let news = news {
            List(news.articles, id: \.url) { article in
                VStack(alignment: .leading) {
                    if let urlToImage = article.urlToImage, let imageUrl = URL(string: urlToImage) {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable().aspectRatio(contentMode: .fit)
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(height: 200)
                    }
                    
                    Text(article.title)
                        .font(.headline)
                        .padding(.bottom, 2)
                    
                    if let author = article.author, !author.isEmpty {
                        Text("By \(author)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 2)
                    }
                    
                    if let description = article.description, !description.isEmpty {
                        Text(description)
                            .font(.body)
                            .padding(.bottom, 2)
                    }
                }
            }
        } 
        else {
            VStack {
                Text("News Reporter").font(.title)
                
                Form {
                    Section(header: Text("News Query")) {
                        TextField("Keyword", text: $keyword)
    //                    TextField("Country", text: $country)
    //                    TextField("Category", text: $category)
                    }
                    Button("Get News") {
                        Task {
                            do {
                                try await news = newsManager.getCurrentNews(keyword: keyword)
                            } catch {
                                print("Error getting news \(error)")
                            }
                        }
                    }
                }
            }
        }
    }
}

    
#Preview {
//    NewsView(news: previewNews)
    NewsView()
}
