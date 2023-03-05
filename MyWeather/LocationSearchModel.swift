//
//  LocationSearchModel.swift
//  MyWeather
//
//  Created by user223354 on 26.1.2023.
//

import Foundation
import SwiftUI

class LocationSearchModel: ObservableObject {
    // use your WeatherModel that you get from the fetch results
    @Published var cityWeather: WeatherSearchModel = WeatherSearchModel()
    
    func fetchWeather(for cityName: String)  {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=44fdbb5ea04faa3569347ae2d4debd81") else { return }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
        guard let data = data, error == nil else { return }
            do {
               // let (data,_) = try await URLSession.shared.data(from: url)
                if let model = try? JSONDecoder().decode(WeatherSearchModel.self, from: data)
                {
                    DispatchQueue.main.async {
                        self.cityWeather = model
                        print(model)
                    }
                }
            }
            catch {
                print(error) // <-- need to deal with errors here
            }
        }
        task.resume()
    }
    
}

struct WeatherSearchModel: Codable {
    var name: String = ""
    var main: CurrentWeather = CurrentWeather()
    var weather: [WeatherInfo] = []
    
    func firstWeatherInfo() -> String {
        return weather.count > 0 ? weather[0].description : ""
    }
}

struct CurrentWeather: Codable {
    var temp: Double = 0.0
}

struct WeatherInfo: Codable {
    var description: String = ""
}
