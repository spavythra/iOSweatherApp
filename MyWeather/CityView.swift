//
//  CityView.swift
//  MyWeather
//
//  Created by user223354 on 27.1.2023.
//

import SwiftUI

struct CityView: View {
    @StateObject var viewModel = LocationSearchModel()
    @State var cityName: String
    
    
    var body: some View {
        //VStack {
        if viewModel.fetchWeather(for: cityName) != nil {
                VStack {
                    Text(viewModel.cityWeather.name)
                        Text("\(Int(viewModel.cityWeather.main.temp))ºC")
                    Text(viewModel.cityWeather.firstWeatherInfo())
                }
            }
        //}
    }
}

struct CityView_Previews: PreviewProvider {
    @State static var cityName: String = ""

    static var previews: some View {
        CityView( cityName: cityName)
    }
}
