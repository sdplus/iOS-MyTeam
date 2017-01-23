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
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    var destinationLocation: CLLocationCoordinate2D!
    var destinationAddress: String!
    var currentLocation: CLLocationCoordinate2D?
    var currentAddress: String?
    let locationManager = CLLocationManager()
    var directions: (startAddress: String, destinationAddress: String, route: MKRoute)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        navigationItem.title = "Route"

        if CLLocationManager.locationServicesEnabled() && isAuthorized() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
        else {
            alertLocationDisabled()
            showStaticMap()
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        navigationController!.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController!.isToolbarHidden = true
    }
    
    func isAuthorized() -> Bool {
        
        locationManager.delegate = self
            
        switch(CLLocationManager.authorizationStatus()) {
            case .restricted, .denied:
                alertLocationDisabled()
                return ( CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways)
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return ( CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways)
        }
        
    }

    func alertLocationDisabled(){
        let alert = UIAlertController(title: "Location Services Disabled", message: "You need to enable location services in settings to get directions.", preferredStyle: UIAlertControllerStyle.alert)
        goToSettingsAction(on: alert)
        present(alert, animated: true)
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
    
    func buildOKAlert(title: String, message: String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func formatCurrentAddress(of userLocation: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) -> Void in

            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                self.currentAddress = (placemark.addressDictionary!["FormattedAddressLines"] as! [String]).joined(separator: ", ")
                //elf.currentAddress = "\(pm.addressDictionary!["Street"]) ,\(pm.postalCode) \(pm.locality!)"

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
                self.buildOKAlert(title: "Directions not available", message: "Unable to get directions")
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
    
    func showStaticMap(){
        mapView.region = MKCoordinateRegion(center: destinationLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        showAnnotation(destinationLocation)
        timeLabel.text = destinationAddress
        distanceLabel.text = ""
    }
    
    func showAnnotation(_ destinationLocation: CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.coordinate = destinationLocation
        pin.title = destinationAddress
        mapView.addAnnotation(pin)
    }
    
    func printTimeToLabel(_ time: TimeInterval) {
        timeLabel.text = time.formatted()
    }
    
    func printDistanceToLabel(_ distance: CLLocationDistance ) {
        distanceLabel.text = distance.toString()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DirectionsViewController
        destination.directions = directions
    }


    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        locationManager.stopUpdatingLocation()

        currentLocation = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        formatCurrentAddress(of: userLocation!)
        getDirections()
        
    }
    

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        buildOKAlert(title: "Failed to get location", message: "An error occured while retrieving your location")
        navigationController!.isToolbarHidden = true
        showStaticMap()
        locationManager.stopUpdatingLocation()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    
}
