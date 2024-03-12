//
//  WelcomeView.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var shouldShowNews = false
    @State private var keyword: String = ""
//    @State private var country: String = ""
//    @State private var category: String = ""
    
    var body: some View {
//        LocationButton(.shareCurrentLocation) {
//            locationManager.requestLocation()
//        }.cornerRadius(30)
//            .symbolVariant(.fill)
//            .foregroundColor(.white)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        VStack {
            Text("News Reporter").font(.title)
            
            Form {
                Section(header: Text("News Query")) {
                    TextField("Keyword", text: $keyword)
//                    TextField("Country", text: $country)
//                    TextField("Category", text: $category)
                }
                Button("Get News") {
                // This would typically trigger the navigation and pass the query values to the news fetching logic
                shouldShowNews = true
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
