//
//  Airport.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/20/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import Foundation
import CoreLocation

class Airport {
    var name : String!
    var iata : String!
    var location : CLLocationCoordinate2D!
    var city : String!
    var state : String!
    var country : String!
    
    convenience init(name : String!, iata: String!, location: CLLocationCoordinate2D, city : String!, state : String!, country : String!) {
        self.init()
        self.iata = iata
        self.name = name
        self.location = location
        self.city = city
        self.state = state
        self.country = country
    }
    
    static func dataToAirports(_ data : Data?) -> [Airport]? {
        var searchResults = [Airport]()
        do {
            if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                
                // Get the results array
                if let array: AnyObject = response["airports"] {
                    for airportDictionary in array as! [AnyObject] {
                        if let airportDictionary = airportDictionary as? [String: AnyObject] {
                            // Parse the search result
                            
                            let lat = (airportDictionary["latitude"] as! NSString!).doubleValue
                            let long = (airportDictionary["longitude"] as! NSString!).doubleValue
                            let iata = airportDictionary["iata"] as? String
                            let location = CLLocationCoordinate2D(latitude: lat as CLLocationDegrees, longitude: long as CLLocationDegrees)
                            let name = airportDictionary["name"] as? String
                            let city = airportDictionary["city"] as? String
                            let state = airportDictionary["state"]?["name"] as? String
                            let country = airportDictionary["country"]?["name"] as? String
                            searchResults.append(Airport(name: name, iata: iata, location: location, city: city, state: state, country: country))
                            print(airportDictionary)
//                            searchResults.append(Airport(name: name!, address: address!, phone: phone!, hours: hours!, menu: menu!))
                        } else {
                            print("Not a dictionary")
                        }
                    }
                } else {
                    print("Results key not found in dictionary")
                }
                
                return searchResults
                
            } else {
                print("JSON Error")
            }
        } catch let error as NSError {
            print("Error parsing results: \(error.localizedDescription)")
        }
        return nil
    }
    
    func printAirport(){
        print("Name: \(self.name!)")
        print("City: \(self.city!)")
        print("State: \(self.state!)")
        print("Country: \(self.country!)")
        print("Latitude: \(self.location.latitude)")
        print("Longitude: \(self.location.longitude)")
    }
    
    
}
