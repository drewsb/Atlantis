//
//  Layover.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/27/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import Foundation

class Layover{
    
    var duration : Int = 0
    
    var carrier: String = ""
    
    var cabin : String = ""
    
    var departureTime : String = ""
    
    var arrivalTime : String = ""
    
    var origin : String = ""
    
    var destination : String = ""
    
    convenience init(duration : Int, carrier : String, cabin: String, departureTime : String, arrivalTime: String, origin : String, destination : String) {
        self.init()
        
        self.duration = duration
        self.carrier = carrier
        self.cabin = cabin
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.origin = origin
        self.destination = destination
    }
}
