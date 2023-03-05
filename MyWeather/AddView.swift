//
//  AddView.swift
//  MyWeather
//
//  Created by user223354 on 26.1.2023.
//


import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var city = ""
    @State private var isAlert = false
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter city name", text: $city)
                        .disableAutocorrection(true)
                }
        
                Button ("Add info") {
                    if self.city == "" {
                        self.isAlert = true
                        return
                    }
                    let cityInfo = CityInfo(context: self.moc)
                    cityInfo.city = self.city
                    do {
                        print(cityInfo)
                        try self.moc.save()
                    } catch {
                        print("whoops \(error.localizedDescription)")
                    }
                }
                .alert(isPresented: $isAlert) { () -> Alert in
                    Alert(title: Text("Alert"), message: Text("No text field should be empty"), dismissButton: .default(Text("Ok")))
                }
            }.navigationBarTitle(Text("Add city View"))
        }
    }
}

#if DEBUG
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
#endif

