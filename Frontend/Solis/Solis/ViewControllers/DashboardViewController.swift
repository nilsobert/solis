//
//  ViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 18.11.22.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var dashboardTableView: UITableView!
    @IBOutlet weak var calculatorButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var tableBackView: UIView!
    @IBOutlet weak var chartTitleLabel: UILabel!
    @IBOutlet weak var titleValueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var leftValueLabel: UILabel!
    @IBOutlet weak var rightValueLabel: UILabel!
    
    var homeService: HomeService!
    var transitionView: UIView!
    
    struct ChartItem {
        var month: String
        var value: String
    }
    
    struct CompletedChart {
        var title: String
        var valuePairs: [ChartItem]
    }
    
    var charts: [CompletedChart]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //corner radius
        tableBackView.clipsToBounds = true
        tableBackView.layer.cornerRadius = 36
        tableBackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        addTransitionView()
        
        homeService = HomeService()
        
        queryUserData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showTransitionView			),
                                               name:Notification.Name("ADD_TRANSITIONVIEW"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeTransitionView),
                                               name:Notification.Name("REMOVE_TRANSITIONVIEW"),
                                               object: nil)
    }
    
    func addTransitionView() {
        transitionView = UIView(frame: .zero)
        transitionView.translatesAutoresizingMaskIntoConstraints = false
        transitionView.backgroundColor = UIColor.init(red: 106/255, green: 106/255, blue: 106/255, alpha: 0.35)
        view.addSubview(transitionView)
        
        NSLayoutConstraint.activate([
            transitionView.topAnchor.constraint(equalTo: view.topAnchor),
            transitionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            transitionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            transitionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        transitionView.isHidden = true
    }
    
    func queryUserData() {
        homeService.performQuery(completion: { (data, state) -> Void in
            
            var items = [ChartItem]()
            var electricityItems = data["electricity"]!
            var heatingItems = data["heating"]!
            var saved = data["saved"]

            print(electricityItems)
            
//            for item in electricityItems {
//                items.append(ChartItem(month: item[0], value: item[1]))
//            }

            //charts.append(CompletedChart(title: "Power per Month", valuePairs: items))
            
        })
    }
    
    @objc func removeTransitionView() {
        transitionView.isHidden = true
    }
    
    @objc func showTransitionView() {
        transitionView.isHidden = false
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("ADD_TRANSITIONVIEW"), object: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "insertoptionChooserViewController") as! InsertoptionChooserViewController
        self.present(nextViewController, animated: true, completion:nil)
        
    }
    


}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2//charts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell", for: indexPath) as? DashboardTableViewCell else { return DashboardTableViewCell() }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

