//
//  Flight.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/26/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import Foundation
import CoreLocation

class Flight {
    
    var origin : String?
    
    var destination : String?
    
    var date : String?
    
    var price : Float?
    
    var duration : Int?

    var layovers : [Layover] = [Layover]()
    
    
    convenience init(origin : String, destination : String, date : String, price: Float, duration : Int, layovers : [Layover]) {
        self.init()

        self.origin = origin
        self.destination = destination
        self.date = date
        self.price = price
        self.duration = duration
        self.layovers = layovers
    }
    
    func printFlight(){
        print("Origin: \(self.origin!)")
        print("Destination: \(self.destination!)")
        print("Price: \(self.price!)")
        print("Date: \(self.date!)")
        print("Duration: \(self.duration!)")
        //print("On: \(self.origin)")
    }
    
    


    
    
}
