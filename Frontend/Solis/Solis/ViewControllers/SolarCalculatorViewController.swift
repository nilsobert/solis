//
//  SolarCalculatorViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 20.11.22.
//

import UIKit
import CoreLocation

class SolarCalculatorViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var longitudeTextfield: UITextField!
    @IBOutlet weak var latitudeTextfield: UITextField!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    
    var locationService: LocationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //corner radius
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 36
        backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 36
        
        resultView.isHidden = true
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func locationButtonClicked(_ sender: Any) {
        
        var locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager.location
            
            longitudeTextfield.text = "\(currentLocation.coordinate.longitude)"
            latitudeTextfield.text = "\(currentLocation.coordinate.latitude)"
        }
    }
    
    @IBAction func completeButtonClicked(_ sender: Any) {
        
        let longitude = longitudeTextfield.text
        let latitude = latitudeTextfield.text
        
        //send data
        locationService = LocationService(lat: latitude!, lon: longitude!)
        locationService.performQuery { data, status in
            let dict = data as? [String : String]
            let savings = dict!["savings"]
            let area = dict!["area"]
            
            self.powerLabel.text = savings
            self.areaLabel.text = area
            self.resultView.isHidden = false
            self.header.text = "Solar panel result"
            self.completeButton.isEnabled = false
        }
    }
    
}

extension SolarCalculatorViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SolarCalculatorViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
