//
//  ContentView.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var newsManager = NewsManager()
    @State var news: ResponseBody?
    
    @State private var shouldShowNews = false
        
    var body: some View {

        if let news = news {
            NewsView(news: news)
        } else if newsManager.isLoading {
            LoadingView()
        } else {
            NewsView()
        }
    }
}

#Preview {
    ContentView()
}
