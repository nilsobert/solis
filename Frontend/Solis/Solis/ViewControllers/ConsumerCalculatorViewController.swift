//
//  ConsumerCalculatorViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 20.11.22.
//

import UIKit

class ConsumerCalculatorViewController: UIViewController {

    @IBOutlet weak var deviceTextfield: UITextField!
    @IBOutlet weak var serialNumberTextfield: UITextField!
    @IBOutlet weak var accessCodeTextfield: UITextField!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var isConsumer: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backView.clipsToBounds = true
        backView.layer.cornerRadius = 36
        backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 36
        
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func completeButtonClicked(_ sender: Any) {
        
        var deviceType = deviceTextfield.text!
        var serialNumber = serialNumberTextfield.text!
        var accessCode = accessCodeTextfield.text!
        
        var role: String!
        if isConsumer {
            role = "consumer"
        } else {
            role = "producer"
        }
        
        let consumerService = ConsumerService(accessCode: accessCode, deviceType: deviceType, role: role, serialNumber: serialNumber)
        
        consumerService.performQuery { data, status in
            
        }
        
    }
    
    @IBAction func backIconClicked(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
}

extension ConsumerCalculatorViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SolarCalculatorViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

