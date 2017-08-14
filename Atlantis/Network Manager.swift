//
//  Network Manager.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/19/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import Foundation

class NetworkManager {
    /*
     // MARK: - TODO: implement NetworkManager methods
     This class is responsible for querying iTunes API
     You need to use closures/completion handlers to define this function.
     
     */
    
    static func retrieve(closure: @escaping ( Data?) -> Void) {
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        var dataTask: URLSessionDataTask?
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let url = URL(string: "https://gist.githubusercontent.com/drewsb/7c62bc6c3ce817ff361c47241fc9d16c/raw/a7572af783564df385b601d196bcec46fdb6a63f/airport.json")
        
        dataTask = defaultSession.dataTask(with: url!, completionHandler: {
            data, response, error in
            if error != nil {
                
                print(error!.localizedDescription)
                closure(nil)
                
            } else if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    if let airportData = data {
                        closure(airportData)
                    }
                    
                }
            }
        })
        
        dataTask?.resume()
    }
    
    static func search (flightSpecs: FlightSpecs, closure: @escaping ( Data?) -> Void) {
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        var dataTask: URLSessionDataTask?
        
        print(flightSpecs.destination!)
        print(flightSpecs.origin!)
        print(flightSpecs.maxPrice!)
        print(flightSpecs.date!)
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let expectedCharSet = CharacterSet.urlQueryAllowed
        let url = URL(string: "https://www.googleapis.com/qpxExpress/v1/trips/search?key=AIzaSyDHFcyZwo9lU0y_92cmktanvLlwdvqZwEg")
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
                
        let body = NSMutableData()
        
        request.httpBody = body as Data
        
        let session = URLSession.shared
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: flightSpecs.toJson(), options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    //print(json)
                    closure(data)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    
}
