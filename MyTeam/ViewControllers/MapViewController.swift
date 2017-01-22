//
//  MapViewController.swift
//  MyTeam
//
//  Created by Sofie De Plus on 21/01/2017.
//  Copyright © 2017 Sofie De Plus. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AddressBookUI

class MapViewController: UIViewController {

    var destinationLocation: CLLocationCoordinate2D!
    var destinationAddress: String!
    var currentLocation: CLLocationCoordinate2D?
    var currentAddress: String?
    let locationManager = CLLocationManager()
    var directions: (startAddress: String, destinationAddress: String, route: MKRoute)!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.region = MKCoordinateRegion(center: destinationLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        showAnnotation(destinationLocation)
        
        if locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController!.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController!.isToolbarHidden = true
    }
    
    func locationServicesEnabled() -> Bool {
        //check if location services are enabled at all
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            
            // Get the current authorization status for this app
            switch(CLLocationManager.authorizationStatus()) {
            case .restricted, .denied:  //this app is not permitted to use location services
                print("No access")
                let accessAlert = UIAlertController(title: "Location Services Disabled", message: "You need to enable location services in settings to get directions.", preferredStyle: UIAlertControllerStyle.alert)
                
                goToSettingsAction(on: accessAlert)
                
                
                present(accessAlert, animated: true, completion: nil)
                return true
                
            
            case .authorizedAlways, .authorizedWhenInUse: // services are allowed for this app
                print("Access! We're good to go!")
                return true
            case .notDetermined:    // we need to ask for access
                print("asking for access...")
                locationManager.requestWhenInUseAuthorization() // Request permission to use location services
                return true
            }
            
        }
        //location services are disabled on the device entirely!
        print("Location services are not enabled on this device")
        let alert = UIAlertController(title: "Location Services Disabled", message: "Location services are not enabled on this device.", preferredStyle: UIAlertControllerStyle.alert)
        present(alert, animated: true)
        return false
    }
    
    func goToSettingsAction(on alertController: UIAlertController){
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
    }
    
    func getCurrentAddress(of userLocation: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) -> Void in

            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.currentAddress = "\(pm.addressDictionary!["Street"]) ,\(pm.postalCode) \(pm.locality!)"
                
            }
           
                print("Problem with the data received from geocoder")
            return
        })
    }
    
    
    func getDirections(){
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation!))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation, addressDictionary: nil))
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate(completionHandler: {(response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Directions not available", message: "Unable to get directions", preferredStyle: UIAlertControllerStyle.alert)
                self.present(alert, animated: true)
            } else {
                self.showRoute(response!)
                self.mapView.showsUserLocation = true
            }})
            
        
    }
        
    func showRoute(_ response: MKDirectionsResponse) {
            
        for route in response.routes {
            mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)

    
            for step in route.steps {
                print(step.instructions)
                directions = (startAddress: currentAddress!, destinationAddress: destinationAddress, route)
            }
            
            printTimeToLabel(route.expectedTravelTime)
            printDistanceToLabel(route.distance)
        }
    }
    
    func showAnnotation(_ destinationLocation: CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.coordinate = destinationLocation
        pin.title = destinationAddress
        mapView.addAnnotation(pin)
    }
    
    func printTimeToLabel(_ time: TimeInterval) {
        timeLabel.text = "Reistijd: \(time.formatted())"
    }
    
    func printDistanceToLabel(_ distance: CLLocationDistance ) {
        distanceLabel.text = distance.toString()
    }
    
    func showDirections(sender: UIBarButtonItem) {
        // performSegue(withIdentifier: "showDirections", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DirectionsViewController
        destination.directions = directions
    }


    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print("Location failed")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        locationManager.stopUpdatingLocation()

        currentLocation = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        getCurrentAddress(of: userLocation!)
        getDirections()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }

    
}
