//
//  ViewController.swift
//  MapViewExample
//
//  Created by Apple MacBook on 26/10/2019.
//  Copyright © 2019 Apple MacBook. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    
    
    
    let homeLatitude = 52.3942
    let homeLongitude = -4.01586
    
    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let span = MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: homeLatitude, longitude: homeLongitude), span: span)
        
        
        mapView.setRegion(region, animated: true)
        
        // add pin to ma
        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(homeLatitude,homeLongitude)
        let pinObject = MKPointAnnotation()
        pinObject.coordinate = pinLocation
        pinObject.title = "Wales"
        pinObject.subtitle = "in Welsh: Cymru"
        
        self.mapView.addAnnotation(pinObject)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func btnStandard_clicked(_ sender: Any) {
        
        mapView.mapType = MKMapType.standard
    }
    
    @IBAction func btnSatellite_clicked(_ sender: Any) {
        
        mapView.mapType = MKMapType.satellite
    }
    
    
    @IBAction func btnHybrid_clicked(_ sender: Any) {
        
        mapView.mapType = MKMapType.hybrid
    }
    
    @IBAction func btnLocateMe_clicked(_ sender: Any) {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        //Requests the user’s permission to use location services while the app is in use.
        //You must call this method or requestAlwaysAuthorization() before you can receive location-related information
        manager.requestWhenInUseAuthorization()
        
        //Starts the generation of updates that report the user’s current location and triggers the
        // locationManagerDidPauseLocationUpdates function
        manager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
    }
    
    
    
    // When the location manager detects that the device’s location is not changing, it can pause the delivery of updates in order to shut down the appropriate hardware and save power. When it does this, it calls this method to let your app know that this has happened.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        
        // add to mapview object
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func btnDirections_Clicked(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "http://maps.apple.com/maps?daddr=\(homeLatitude),\(homeLongitude)")!, options: [:], completionHandler: nil)
    }
    
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
    {
        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
        }
    }

}

