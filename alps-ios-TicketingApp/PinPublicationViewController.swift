//
//  PinPublicationViewController.swift
//  alps-ios-TicketingApp
//
//  Created by Wen on 05.09.17.
//  Copyright © 2017 WhenWens. All rights reserved.
//

import UIKit
import MapKit
import AlpsSDK

class PinPublicationViewController: UIViewController {
    
    
    @IBOutlet weak var concertTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var imageTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longtitudeTextField: UITextField!
    @IBOutlet weak var rangeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var publishButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 1000
    var i = 1
    
    // Using appDelegate as a singleton
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var alps : AlpsManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alps = self.appDelegate.alps
        let initialLocation = self.appDelegate.locationManager.location
        centerMapOnLocation(location: initialLocation!)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        publishButton.isEnabled = true
        if let lat = self.appDelegate.locationManager.location?.coordinate.latitude, let long = self.appDelegate.locationManager.location?.coordinate.longitude{
            latitudeTextField.text = String(lat)
            longtitudeTextField.text = String(long)
        }
        
    }
    
    @IBAction func publishAction(_ sender: Any) {
        publishButton.isEnabled = false
        
        if let price = Double(priceTextField.text!), let range = Double(rangeTextField.text!), let duration = Double(durationTextField.text!), let image = imageTextField.text, let concert = concertTextField.text, let longitude = Double(longtitudeTextField.text!), let latitude = Double(latitudeTextField.text!) {
            createPublication(concert: concert, price: price, image: image, latitude: latitude, longitude: longitude, range: range, duration: duration, completion: {
                () in
                self.navigationController?.popToRootViewController(animated: true)
            })
        } else {
            print("Issue with price.")
            print("Issue with duration.")
            print("Issue with range.")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    // MARK: - AlpsSDK
    func createPublication(concert: String, price: Double, image: String, latitude: Double, longitude: Double, range: Double, duration: Double, completion: @escaping () -> Void) {
        self.appDelegate.alps.createPinDevice(name: "pin device \(i)", latitude: latitude, longitude: longitude, altitude: 0.0, horizontalAccuracy: 1.0, verticalAccuracy: 1.0, completion: {
            (_ device) in
            print("PIN DEVICE CREATED")
                // XXX: the property syntax is tricky at the moment: mood is a variable and 'happy' is a string value
                var properties : [String:String] = [:]
                properties["concert"] = concert
                properties["price"] = "\(price)"
                properties["image"] = image
                properties["deviceType"] = "pin"
            if let deviceId = device?.id{
                self.alps.createPublication(userId: self.appDelegate.userId!, deviceId: deviceId, topic: "ticketstosale", range: range, duration: duration, properties: properties, completion: {
                    (_ publication) in
                    if let p = publication {
                        print("Created publication: id = \(String(describing: p.id)), topic = \(String(describing: p.topic)), properties = \(String(describing: p.properties))")
                        self.i += 1
                        completion()
                    }
                })
            }
            
        })
    }

}
