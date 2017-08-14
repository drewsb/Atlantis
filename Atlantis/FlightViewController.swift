//
//  FlightViewController.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/27/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import UIKit

class FlightViewController: UIViewController {

    @IBOutlet var departureLabel: UILabel!
    
    
    @IBOutlet var arrivalLabel: UILabel!
    
    
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var durationLabel: UILabel!

    @IBOutlet var layoverDepartLabel1: UILabel!

    @IBOutlet var layoverDepartLabel2: UILabel!
    
    @IBOutlet var layoverDepartLabel3: UILabel!

    @IBOutlet var layoverDepartLabel4: UILabel!
    
    @IBOutlet var layoverArrivalLabel1: UILabel!
    
    @IBOutlet var layoverArrivalLabel2: UILabel!

    @IBOutlet var layoverArrivalLabel3: UILabel!
    
    @IBOutlet var layoverArrivalLabel4: UILabel!
    
    @IBOutlet var layoverTimeLabel1: UILabel!
    
    @IBOutlet var layoverTimeLabel2: UILabel!
    
    @IBOutlet var layoverTimeLabel3: UILabel!
    
    @IBOutlet var layoverTimeLabel4: UILabel!
    
    @IBOutlet var classLabel1: UILabel!

    @IBOutlet var classLabel2: UILabel!
    
    @IBOutlet var classLabel3: UILabel!
    
    @IBOutlet var classLabel4: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let someFloatFormat = ".2"
        departureLabel.text = selectedFlight.origin
        arrivalLabel.text = selectedFlight.destination
        //priceLabel.text = "$\(selectedFlight.price!)0"
        priceLabel.text = String(format: "$%.2f", (selectedFlight.price!))
        durationLabel.text = String(format: "%.1f hrs", (Float(selectedFlight.duration!)/60))
        
        resetLayovers()
        let count = selectedFlight.layovers.count
        if(count > 0) {
            layoverDepartLabel1.text = selectedFlight.layovers[0].origin
            layoverArrivalLabel1.text = selectedFlight.layovers[0].destination
            layoverTimeLabel1.text = "\(selectedFlight.layovers[0].departureTime) - \(selectedFlight.layovers[0].arrivalTime)"
            classLabel1.text = selectedFlight.layovers[0].cabin
        }
        if(count > 1) {
            layoverDepartLabel2.text = selectedFlight.layovers[1].origin
            layoverArrivalLabel2.text = selectedFlight.layovers[1].destination
            layoverTimeLabel2.text = "\(selectedFlight.layovers[1].departureTime) - \(selectedFlight.layovers[1].arrivalTime)"
            classLabel2.text = selectedFlight.layovers[1].cabin
        }
        if(count > 2) {
            layoverDepartLabel3.text = selectedFlight.layovers[2].origin
            layoverArrivalLabel3.text = selectedFlight.layovers[2].destination
            layoverTimeLabel3.text = "\(selectedFlight.layovers[2].departureTime) - \(selectedFlight.layovers[2].arrivalTime)"
            classLabel3.text = selectedFlight.layovers[3].cabin
        }
        if(count > 3) {
            layoverDepartLabel4.text = selectedFlight.layovers[3].origin
            layoverArrivalLabel4.text = selectedFlight.layovers[3].destination
            layoverTimeLabel4.text = "\(selectedFlight.layovers[3].departureTime) - \(selectedFlight.layovers[3].arrivalTime)"
            classLabel4.text = selectedFlight.layovers[3].cabin
        }

    }
    
    func resetLayovers(){
        layoverDepartLabel1.text = ""
        layoverDepartLabel2.text = ""
        layoverDepartLabel3.text = ""
        layoverDepartLabel4.text = ""
        layoverArrivalLabel1.text = ""
        layoverArrivalLabel2.text = ""
        layoverArrivalLabel3.text = ""
        layoverArrivalLabel4.text = ""
        layoverTimeLabel1.text = ""
        layoverTimeLabel2.text = ""
        layoverTimeLabel3.text = ""
        layoverTimeLabel4.text = ""
        classLabel1.text = ""
        classLabel2.text = ""
        classLabel3.text = ""
        classLabel4.text = ""

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
