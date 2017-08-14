//
//  FlightSpecs.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/27/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import Foundation

class FlightSpecs {
    
    var origin : String?
    
    var destination : String?
    
    var maxPrice : Int?
    
    var adultCount : Int?
    
    var date : String?
    
    var prohibitedCarriers : String?
    
    
    
    convenience init(origin : String, destination : String, date : String, maxPrice: Int, adultCount : Int) {
        self.init()

        self.origin = origin
        self.destination = destination
        self.date = date
        self.maxPrice = maxPrice
        self.adultCount = adultCount
        
    }
    
    func toJson() -> [String:AnyObject]{
        let output : [String:AnyObject] = [
            "request": [
                "passengers": [
                    "adultCount" : adultCount!
                ] ,
                "slice" : [
                    [
                        "origin": "\(String(describing: self.origin!))" ,
                        "destination": "\(String(describing: self.destination!))",
                        "date": "\(String(describing: self.date!))"
                    ],
                ],
                "maxPrice": "USD\(String(describing: self.maxPrice!)).00"
                ] as AnyObject
        ]
        //
        return output
    }

}
