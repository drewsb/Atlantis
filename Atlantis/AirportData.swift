//
//  AirportData.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/20/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import Foundation
import CoreLocation


class AirportData {
    
    fileprivate static var airports = [Airport]()
    
    fileprivate static var locations = [String: CLLocationCoordinate2D]()

    static func getAirPorts() -> [Airport] {
        return airports
    }
    
    static func storeAirports(airportArr : [Airport]) {
        airports = airportArr
    }
    
    static func addAirport(airport : Airport){
        self.airports.append(airport)
    }
    
    static func findLocation(name: String) -> CLLocationCoordinate2D {
        return locations[name]!
    }
    
    static func addLocation(name : String, location : CLLocationCoordinate2D) {
        locations[name] = location
    }
    
    static func findName(name: String) -> Airport {
        var output = Airport()
        for airport in airports {
            if(airport.name == name){
                output = airport
            }
        }
        return output
    }
    
    static func findName(location : CLLocationCoordinate2D) -> Airport {
        var output = Airport()
        for airport in airports {
            if(airport.location.latitude == location.latitude &&
                airport.location.longitude == location.longitude){
                output = airport
            }
        }
        return output
    }
}
