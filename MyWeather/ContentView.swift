//
//  ContentView.swift
//  MyWeather
//
//  Created by user223354 on 26.1.2023.

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var locationDataManager = LocationDataManager()
    @StateObject var viewModel = LocationSearchModel()
        @State private var cityName = ""

    
    var body: some View {
        TabView {
            CurrentLocationView()
            .tabItem {
                Image(systemName: "house.fill")
            }
            Text("forecast")
                .tabItem {
                    Image(systemName: "cloud")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
