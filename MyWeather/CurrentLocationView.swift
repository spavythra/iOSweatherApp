//
//  CurrentLocationView.swift
//  MyWeather
//
//  Created by user223354 on 27.1.2023.
//

import SwiftUI

struct CurrentLocationView: View {
    @StateObject var locationDataManager = LocationDataManager()
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            if let currentWeather = locationDataManager.currentWeather  {
                HStack(alignment: .center, spacing: 16) {
                    currentWeather.weatherCode.image
                        .font(.largeTitle)
                    Text("\(currentWeather.temperature)º")
                        .font(.largeTitle)
                }
                Text(currentWeather.weatherCode.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                
            } else {
                Text("No weather info available yet.\nTap on refresh to fetch new data.\nMake sure you have enabled location permissions for the app.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Button("Refresh", action: {
                    Task {
                        await locationDataManager.fetchWeather()
                    }
                })
            }
            Spacer()
        }
        
        .onAppear {
            Task {
                await locationDataManager.fetchWeather()
            }
        }
        
    }
}

struct CurrentLocationView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocationView()
    }
}
