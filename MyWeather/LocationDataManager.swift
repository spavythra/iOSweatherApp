//
//  LocationDataManager.swift
//  MyWeather
//
//  Created by user223354 on 26.1.2023.
//

import Foundation
import CoreLocation

class LocationDataManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var currentWeather: WeatherDetail?
    private let dateFormatter = ISO8601DateFormatter()
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
        return
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
            
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func fetchWeather() async {
            guard let location = locationManager.location else {
                requestLocation()
                return
            }
            
        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&fields=temperature&fields=weatherCode&units=metric&timesteps=1h&startTime=\(dateFormatter.string(from: Date()))&endTime=\(dateFormatter.string(from: Date().addingTimeInterval(60 * 60)))&apikey=8z9We8mOtEbisqEmUqSzGEjDj97qprwD") else {
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data),
                   let weatherValue = weatherResponse.data.timelines.first?.intervals.first?.values,
                   let weatherCode = WeatherCode(rawValue: "\(weatherValue.weatherCode)") {
                    DispatchQueue.main.async { [weak self] in
                        self?.currentWeather = WeatherDetail(temperature: Int(weatherValue.temperature),
                                                       weatherCode: weatherCode)
                        print(self?.currentWeather)
                    }
                }
            } catch {
                // handle the error
            }
        }
        
        private func requestLocation() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task { await fetchWeather() }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    
}
