//
//  InsertoptionChooserViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//

import UIKit

class InsertoptionChooserViewController: UIViewController {
    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var consumerView: UIView!
    @IBOutlet weak var producerView: UIView!
    @IBOutlet weak var dragView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backView.layer.cornerRadius = 36
        backView.layer.masksToBounds = true
        
        dragView.layer.cornerRadius = 2.5
        dragView.layer.masksToBounds = true
        
        producerView.layer.cornerRadius = 22
        producerView.layer.masksToBounds = true
        
        consumerView.layer.cornerRadius = 22
        consumerView.layer.masksToBounds = true
        
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        backgroundView.addGestureRecognizer(backgroundTap)
        
        let producerTap = UITapGestureRecognizer(target: self, action: #selector(self.producerTapped(_:)))
        producerView.addGestureRecognizer(producerTap)
        
        let consumerTap = UITapGestureRecognizer(target: self, action: #selector(self.consumerTapped(_:)))
        consumerView.addGestureRecognizer(consumerTap)
        
        setupGestureRecognizers()
    }
    
    private func setupGestureRecognizers() {
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(swipe:)))
        downSwipe.direction = UISwipeGestureRecognizer.Direction.down
        backView.addGestureRecognizer(downSwipe)
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        
        NotificationCenter.default.post(name: Notification.Name("REMOVE_TRANSITIONVIEW"), object: nil)
        
        self.tabBarController?.selectedIndex = 1
        
        self.dismiss(animated: true)
    }
    
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer? = nil) {
        NotificationCenter.default.post(name: Notification.Name("REMOVE_TRANSITIONVIEW"), object: nil)
        self.dismiss(animated: true)
    }
    
    @objc func producerTapped(_ sender: UITapGestureRecognizer? = nil) {
        let calculator = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConsumerCalculatorViewController") as! ConsumerCalculatorViewController
        calculator.isConsumer = false
        self.present(calculator, animated: true, completion: nil)
        
    }

    @objc func consumerTapped(_ sender: UITapGestureRecognizer? = nil) {
        
        let calculator = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConsumerCalculatorViewController") as! ConsumerCalculatorViewController
        calculator.isConsumer = true
        self.present(calculator, animated: true, completion: nil)
        
        
    }
}
