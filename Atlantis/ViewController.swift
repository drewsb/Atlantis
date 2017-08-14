//
//  ViewController.swift
//  Atlantis
//
//  Created by Drew Boyette on 4/19/17.
//  Copyright © 2017 Drew Boyette. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

var sourceAirport : Airport = Airport()

var destAirport : Airport = Airport()


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var currentShop : String = ""
    
    var currentDistance : Int = 0
    
    var currentLocation : String = ""
    
    var currentAirport : Airport!
    
    @IBOutlet weak var arrivalButton: UIButton!
    
    let manager = CLLocationManager()
    
    var userLocation : CLLocation!
    
    var sourceAnn: MKAnnotationView!
    
    var destinationAnn : MKAnnotationView!
    
    let blueIcon = UIImage(named: "blue.png")
    
    let greenIcon = UIImage(named: "green.png")
    
    let redIcon = UIImage(named: "red.png")

    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var distanceLabel: UILabel!

    @IBOutlet weak var arrivalCountryLabel: UILabel!
    
    @IBOutlet weak var departCountryLabel: UILabel!
    
    
    @IBOutlet weak var flightsButton: UIBarButtonItem!

    
    @IBOutlet weak var mapView: MKMapView!{
        didSet {
            self.mapView.delegate = self
            self.mapView.mapType = .standard
            self.mapView.showsUserLocation = true
        }
    }

    func handlePress(sender: UILongPressGestureRecognizer) {
//        sourceAnn.canShowCallout = false
//        destinationAnn.canShowCallout = false
        if(self.mapView.selectedAnnotations.count > 0){
            self.mapView.deselectAnnotation(self.mapView.selectedAnnotations[0], animated: true)
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGestures()
        
        NetworkManager.retrieve(closure: { (data) in
            AirportData.storeAirports(airportArr: Airport.dataToAirports(data)!)
            DispatchQueue.main.sync {
                self.updateMap()
            }
            
        })
        
        originLabel.text = ""
        destinationLabel.text = ""
        departCountryLabel.text = ""
        arrivalCountryLabel.text = ""
        distanceLabel.text = ""
        
        // setting up
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        
        // request permission
        self.manager.requestAlwaysAuthorization()
        
        // actually start getting location
        self.manager.startUpdatingLocation()
        
        var initialCenter :  CLLocationCoordinate2D = CLLocationCoordinate2D()
        initialCenter.latitude = 39.8282
        initialCenter.longitude = -98.5795
        
        let region = MKCoordinateRegion(center: initialCenter, span: MKCoordinateSpan(latitudeDelta: 50.0, longitudeDelta: 50.0))
        self.mapView.showsUserLocation = false
        self.mapView.setRegion(region, animated: true)
        
    }
    
    
    func updateMap() {
        for airport in AirportData.getAirPorts() {
            let name = airport.name
            let location = airport.location
            AirportData.addLocation(name: name!, location: location!)
            let info = CustomPointAnnotation()
            info.coordinate = location!
            info.title = name
            info.imageName = "blue.png"
            info.subtitle = "\(airport.city!), \(airport.state!)"
            self.mapView.addAnnotation(info)
        }
    }
    
    func mapView(_ viewFormapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }
        if(sourceAnn) != nil {
            if(sourceAirport.location.latitude == anView?.annotation?.coordinate.latitude && sourceAirport.location.longitude == anView?.annotation?.coordinate.longitude){
                return sourceAnn
            }
        }

        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomPointAnnotation
        anView?.image = UIImage(named:cpa.imageName)
        let image2 = UIImage(cgImage: (anView?.image?.cgImage)!, scale: 10.0, orientation: UIImageOrientation.up)
        anView?.image = image2
        return anView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if(sourceAnn) != nil{
            if(sourceAnn == view){
                return
            }

            if(destinationAnn) != nil{
                destinationAnn.image = UIImage(cgImage: (blueIcon?.cgImage)!, scale: 10.0, orientation: UIImageOrientation.up)
            }
            destinationAnn = view
            destinationAnn.image = UIImage(cgImage: (redIcon?.cgImage)!, scale: 8.0, orientation: UIImageOrientation.up)
            destAirport = AirportData.findName(location: (view.annotation?.coordinate)!)
            drawLine(source: sourceAirport.location, destination: destAirport.location)
        }
        else{
            //Select new annotation
            sourceAnn = view
            sourceAnn.image =  UIImage(cgImage: (greenIcon?.cgImage)!, scale: 8.0, orientation: UIImageOrientation.up)
            sourceAirport = AirportData.findName(location: (view.annotation?.coordinate)!)
        }
        if let sourceAnn = sourceAnn {

            sourceAirport = AirportData.findName(location: sourceAirport.location)
            self.originLabel.text = sourceAirport.name
            self.departCountryLabel.text = sourceAirport.country
        }
        if (destinationAnn) != nil{
            destAirport = AirportData.findName(location: destAirport.location)
            self.destinationLabel.text = destAirport.name
            self.arrivalCountryLabel.text = destAirport.country
            let sourceLoc = CLLocation(latitude: sourceAirport.location.latitude, longitude: sourceAirport.location.longitude)
            let destLoc = CLLocation(latitude: destAirport.location.latitude, longitude: destAirport.location.longitude)
            self.currentDistance = Int(sourceLoc.distance(from: destLoc))
            self.distanceLabel.text = "Distance: \(currentDistance/5280) miles"
        }
    }
    
    func drawLine(source : CLLocationCoordinate2D, destination : CLLocationCoordinate2D){
        removeOverlays()
        let locations : [CLLocationCoordinate2D] = [sourceAirport.location, destAirport.location]
        let geodesic = MKGeodesicPolyline(coordinates: locations, count: 2)
        self.mapView.add(geodesic, level: MKOverlayLevel.aboveRoads)
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 2
            return polylineRenderer
        }
        
        return MKOverlayRenderer()
    }
    
    func setUpGestures(){
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handlePress))
        self.mapView.addGestureRecognizer(longPress)
    }
    
    func removeOverlays(){
        let overlays = mapView.overlays
        self.mapView.removeOverlays(overlays)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        removeOverlays()
        if(sourceAnn) != nil {
            sourceAnn.image = UIImage(cgImage: (blueIcon?.cgImage)!, scale: 10.0, orientation: UIImageOrientation.up)
            sourceAnn = nil
        }
        if(destinationAnn) != nil{
            destinationAnn.image = UIImage(cgImage: (blueIcon?.cgImage)!, scale: 10.0, orientation: UIImageOrientation.up)
            destinationAnn = nil
        }
    }
}

