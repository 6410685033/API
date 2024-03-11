//
//  NewsView.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import SwiftUI

struct NewsView: View {
    var news: ResponseBody
    
    var body: some View {
        VStack {
            Text(news.name)
                .bold()
                .font(.title)
//            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png"))
//                .frame(width: 350, height: 350)
            
        }
    }
}

#Preview {
    NewsView(news: previewNews)
}
