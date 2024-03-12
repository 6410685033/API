//
//  ContentView.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
        @State var news: ResponseBody?
        
        var body: some View {
            VStack {
                if let _ = locationManager.location {
                    NewsView(keyword: "apple")
                } else if locationManager.isLoading {
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
