//
//  CalculatorChooserViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//

import UIKit

class CalculatorChooserViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dragView: UIView!
    @IBOutlet weak var solarPanelView: UIView!
    @IBOutlet weak var heatPumpView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView.layer.cornerRadius = 36
        backView.layer.masksToBounds = true
        
        dragView.layer.cornerRadius = 2.5
        dragView.layer.masksToBounds = true
        
        solarPanelView.layer.cornerRadius = 22
        solarPanelView.layer.masksToBounds = true
        
        heatPumpView.layer.cornerRadius = 22
        heatPumpView.layer.masksToBounds = true
        
        let solarTap = UITapGestureRecognizer(target: self, action: #selector(self.solarTapped(_:)))
        solarPanelView.addGestureRecognizer(solarTap)
        
        let heatPumpTap = UITapGestureRecognizer(target: self, action: #selector(self.heatPumpTapped(_:)))
        heatPumpView.addGestureRecognizer(heatPumpTap)
        
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        backgroundView.addGestureRecognizer(backgroundTap)
        
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(swipe:)))
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        backView.addGestureRecognizer(downSwipe)
    }
    
    @objc func solarTapped(_ sender: UITapGestureRecognizer? = nil) {
        let calculator = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "solarCalculatorViewController") as! SolarCalculatorViewController
        self.present(calculator, animated: true, completion: nil)
        self.tabBarController?.present(calculator, animated: true)
        
    }
    
    @objc func remove() {
        self.dismiss(animated: true)
    }
    
    @objc func heatPumpTapped(_ sender: UITapGestureRecognizer? = nil) {
        pushCalculator()
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer? = nil) {
        NotificationCenter.default.post(name: Notification.Name("REMOVE_TRANSITIONVIEW"), object: nil)
        self.dismiss(animated: true)
    }
    
    func pushCalculator() {
        let calculator = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "calculatorViewController") as! CalculatorViewController
        self.present(calculator, animated: true, completion: {
            //self.dismiss(animated: true)
        })
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        NotificationCenter.default.post(name: Notification.Name("REMOVE_TRANSITIONVIEW"), object: nil)
        
        self.tabBarController?.selectedIndex = 1
        
        
        self.dismiss(animated: true)
    }
    
}
