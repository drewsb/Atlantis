//
//  FlightData.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/27/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import Foundation
import UIKit

class FlightData {
    
    fileprivate static var flights = [Flight]()

    
    static func getFlights() -> [Flight] {
        return flights
    }
    
    static func storeFlights(flightArr : [Flight]) {
        flights = flightArr
    }
    
    static func addAirport(flight : Flight){
        self.flights.append(flight)
    }
    
    static func dataToFlights(_ data : Data?) -> [Flight]? {
        var searchResults = [Flight]()
        do {
            if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? [String: AnyObject] {
                print(response)
                // Get the results array
                if let trips : [String:AnyObject] = response["trips"] as? [String:AnyObject]{
                    if let array: AnyObject = trips["tripOption"] {
                        for airportDictionary in array as! [AnyObject] {
                            if let airportDictionary = airportDictionary as? [String: AnyObject] {
                                // Parse the search result
                                var priceStr = String(describing: airportDictionary["saleTotal"]!)
                                let startIndex = priceStr.index(priceStr.startIndex, offsetBy: 3)
                                priceStr = priceStr.substring(from: startIndex)
                                let price = Float(priceStr)
                                var tempLayovers = [Layover]()
                                var duration = 0
                                if let sliceArray : AnyObject = airportDictionary["slice"] {
                                    for sliceDictionary in sliceArray as! [AnyObject] {
                                        if let sliceDictionary : [String:AnyObject] = sliceDictionary as? [String : AnyObject]{
                                            duration = Int(String(describing: sliceDictionary["duration"]!))!
                                            if let segArray : AnyObject = sliceDictionary["segment"] {
                                                for flightDictionary in segArray as! [AnyObject]{
                                                    if let flightDictionary = flightDictionary as? [String: AnyObject]{
                                                        let layoverDuration = flightDictionary["duration"]
                                                        let cabin = flightDictionary["cabin"]
                                                        var carrier = ""
                                                        var arrivalTime = ""
                                                        var departureTime = ""
                                                        var origin = ""
                                                        var destination = ""
                                                        if let flightCarrier : [String:AnyObject] = flightDictionary["flight"] as! [String : AnyObject]{
                                                            carrier = String(describing: flightCarrier["carrier"]!) + String(describing: flightCarrier["number"]!)
                                                        }
                                                        if let flightLeg : AnyObject = flightDictionary["leg"]{
                                                            for legDictionary in flightLeg as! [AnyObject] {
                                                                if let legDictionary : [String:AnyObject] = legDictionary as? [String:AnyObject]{
                                                                    arrivalTime = legDictionary["arrivalTime"] as! String
                                                                    departureTime = legDictionary["departureTime"] as! String
                                                                    origin = legDictionary["origin"] as! String
                                                                    destination = legDictionary["destination"] as! String
                                                                    break
                                                                }
                                                            }
                                                        }
                                                        let layover = Layover(duration: layoverDuration as! Int, carrier: carrier, cabin: cabin as! String, departureTime: departureTime, arrivalTime: arrivalTime, origin : origin, destination: destination)
                                                        tempLayovers.append(layover)
                                                    }
                                                }
                                        
                                            }
                                        }
                                    }
                                }
                                let newFlight = Flight(origin: flightSpecs.origin!, destination: flightSpecs.destination!, date: flightSpecs.date!, price: price!, duration: Int(duration), layovers: tempLayovers)
                                searchResults.append(newFlight)
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
            }
            else{
                noResults = true
                print("No results")
            }
        } catch let error as NSError {
            noResults=true
            print("Error parsing results: \(error.localizedDescription)")
        }
        noResults = true
        return nil
    }
}
