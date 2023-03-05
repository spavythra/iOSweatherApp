//
//  CityInfo+CoreDataProperties.swift
//  MyWeather
//
//  Created by user223354 on 27.1.2023.
//
//

import Foundation
import CoreData


extension CityInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityInfo> {
        return NSFetchRequest<CityInfo>(entityName: "CityInfo")
    }

    @NSManaged public var city: String?

}

extension CityInfo : Identifiable {

}
