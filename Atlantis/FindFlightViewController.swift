//
//  FindFlightViewController.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/27/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import UIKit

var flightSpecs : FlightSpecs!

var noResults : Bool = false

class FindFlightViewController: UIViewController {

    
    @IBOutlet weak var adultCountField: UITextField!
    
    @IBOutlet weak var maxPriceField: UITextField!
    
    @IBOutlet weak var departureLabel: UILabel!
    
    @IBOutlet weak var arrivalLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet var searchFlight: UIButton!
    
    var time : String = ""
    
    var date : String = ""
    
    var adultCount : Int = 0
    
    var maxPrice : Int = 0
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findFlightsButton(_ sender: UIButton) {
        if(noResults){
            showAlert()
            noResults = false
        }
        if(sourceAirport.iata == nil) || (destAirport.iata == nil){
            showAlert()
            return
        }
        if let maxPrice = Int(maxPriceField.text!),  let adultCount = Int(adultCountField.text!)
        {
            date = String(describing: datePicker.date).components(separatedBy: " ")[0]
            time = String(describing: datePicker.date).components(separatedBy: " ")[1]
            flightSpecs = FlightSpecs(origin: sourceAirport.iata, destination: destAirport.iata, date: date, maxPrice: maxPrice, adultCount: adultCount)
        }
        else{
            showAlert()
        }
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(sourceAirport.iata) != nil && (destAirport.iata) != nil {
            self.navigationItem.title = "\(sourceAirport.iata!) to \(destAirport.iata!)"
        }
        searchFlight.layer.cornerRadius = 10.0
        departureLabel.text = ""
        departureLabel.text = sourceAirport.name
        arrivalLabel.text = destAirport.name
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // When do we call this method?
    
    func showAlert() {
        let alert = UIAlertController(title: "Oops", message:"Invalid Input or No Results. Try again.", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
