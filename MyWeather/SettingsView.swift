//
//  SettingsView.swift
//  MyWeather
//
//  Created by user223354 on 26.1.2023.
//
import SwiftUI

struct SettingsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CityInfo.entity(), sortDescriptors: [NSSortDescriptor(key: "city", ascending: true)])
    private var cities: FetchedResults<CityInfo>
    @State private var showingAddCity = false
    @State private var cityName = ""
    //@StateObject var viewModel = LocationSearchModel()
    

    var body: some View {
        NavigationView {
            VStack {
                TextField("City name", text: $cityName)
                
                HStack {
                    Spacer()
                    Button("Add") {
                        let newCity = CityInfo(context: moc)
                        newCity.city = cityName
                        do {
                            try moc.save()
                        }
                        catch {
                            let error = error as NSError
                            fatalError("An error occured: \(error)")
                        }
                        
                    }
                    Spacer()
                    Button("Clear") {
                        cityName = ""
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                List{
                    ForEach(cities){city in
                        HStack {
                            NavigationLink(destination: CityView(cityName: city.city!)) {
                                Text(city.city ?? "not found")
                            }
                            
                        }
                        
                    }
                    .onDelete(perform: deleteCity)
                    HStack {
                        NavigationLink( destination: CurrentLocationView()) {
                            Text("Current Location")
                        }
                    }
                }
                .navigationTitle("Selected cities")
            }
                    
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
    func deleteCity(offsets: IndexSet) {
            offsets.map {cities[$0]}.forEach(moc.delete)
            do {
                try moc.save()
            }
            catch {
                let error = error as NSError
                fatalError("An error occured: \(error)")
            }
    }
}
    
    
    struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


