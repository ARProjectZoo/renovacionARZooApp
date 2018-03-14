//
//  ArViewController.swift
//  renovacionARZoo
//
//  Created by Kike on 13/3/18.
//  Copyright © 2018 Kike. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation
import MapKit

class ARViewController: UIViewController, CLLocationManagerDelegate
{
    
    var sceneLocationView = SceneLocationView()
    var place : String!
    var locationManager = CLLocationManager()
    var lat : CLLocationDegrees!
    var long : CLLocationDegrees!
    var selectedPlace : Bool!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(selectedPlace){
        sceneLocationView.run()
        
        self.view.addSubview(sceneLocationView)
        self.title = self.place
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        (self.locationManager.location?.coordinate)
        
            findNearPlaces()
            
        }

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findNearPlaces(){
        let location = self.locationManager.location
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        request.region = region
        
        var coordinatesPin = CLLocationCoordinate2D(latitude: lat, longitude: long)
        var locationPin = CLLocation(coordinate: coordinatesPin, altitude: (self.locationManager.location?.altitude)!)
        let placeLocation = locationPin
        let image = UIImage(named : "pin")
        let placeAnnotationNode = LocationAnnotationNode(location: locationPin, image: image!)
        DispatchQueue.main.async{
            self.sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: placeAnnotationNode)
        }
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
