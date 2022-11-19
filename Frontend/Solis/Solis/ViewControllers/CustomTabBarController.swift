//
//  CustomTabBarViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//

import UIKit
import SOTabBar

class CustomTabBarController: SOTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        let calculator = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "calculatorChooserViewController") as! CalculatorChooserViewController
        let dashboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "dashboardViewController") as! DashboardViewController
        let autarchic = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "autarchicViewController") as! AutarchicViewController
        
        dashboard.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), selectedImage: UIImage(named: "firstSelectedImage"))
        calculator.tabBarItem = UITabBarItem(title: "Calculator", image: UIImage(named: "calculatorIcon"), selectedImage: UIImage(named: "secondSelectedImage"))
        autarchic.tabBarItem = UITabBarItem(title: "Autarchic", image: UIImage(named: "autarchicIcon"), selectedImage: UIImage(named: "secondSelectedImage"))
        
        viewControllers = [calculator, dashboard, autarchic]
        
        SOTabBarSetting.tabBarTintColor = UIColor.init(named: "MainGreen")!
        
    }
    

}

extension CustomTabBarController: SOTabBarControllerDelegate {
    func tabBarController(_ tabBarController: SOTabBarController, didSelect viewController: UIViewController) {
        if viewController.isKind(of: CalculatorChooserViewController.self){
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "calculatorChooserViewController") as! CalculatorChooserViewController
            self.present(nextViewController, animated: true, completion:nil)
        }
    }
}
