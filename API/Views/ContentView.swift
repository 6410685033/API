//
//  ContentView.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var newsManager = NewsManager()
    @State var news: ResponseBody?
        
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let news = news {
                    NewsView(news: news)
                }
                else {
                    LoadingView()
                        .task {
                            do {
                                news = try await newsManager.getCurrentNews(keyword: "apple")
                            } catch {
                                print("Error getting news \(error)")
                            }
                        }
                }
            } else if newsManager.isLoading {
                LoadingView()
            } else {
                WelcomeView().environmentObject(locationManager)
            }
        }.background(Color(hue: 1.0, saturation: 0.272, brightness: 1.0)).padding()
    }
}

#Preview {
    ContentView()
}
