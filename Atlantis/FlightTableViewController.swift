//
//  FlightTableViewController.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/27/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import UIKit


var selectedFlight : Flight = Flight()


class FlightTableViewController: UITableViewController {

    var flights : [Flight] = [Flight]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "clouds.jpeg")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill

        self.tableView.backgroundView = imageView
        
        
        NetworkManager.search(flightSpecs: flightSpecs, closure: { (data) in
            self.flights = FlightData.dataToFlights(data)!
            FlightData.storeFlights(flightArr: self.flights)
            for f in self.flights {
                f.printFlight()
            }
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        })
    }
    @IBAction func learnMoreButton(_ sender: UIButton) {
        let buttonRow = sender.tag
        selectedFlight = FlightData.getFlights()[buttonRow]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Flights from \(sourceAirport.iata!) to \(destAirport.iata!)"
        self.tableView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return flights.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FlightCell", for: indexPath) as? FlightTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FlightTableViewCell.")
        }
        let row : Int = indexPath.row
        let currentFlight = FlightData.getFlights()[row]
        
        cell.learnMoreButton.tag = row
        
        cell.priceLabel.text = "$\(currentFlight.price!)0"
        cell.backgroundColor = .clear
        cell.carrierLabel.text = "\(currentFlight.layovers[0].carrier)"
        cell.durationLabel.text = "\(currentFlight.duration!/60) hrs"

        //self.tableView.backgroundView.
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFlight = flights[indexPath.row]
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
