//
//  ViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 18.11.22.
//

import UIKit
import Charts

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
        var keyvalue: String
        var valuePairs: [ChartItem]
    }
    
    var charts = [CompletedChart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //corner radius
        tableBackView.clipsToBounds = true
        tableBackView.layer.cornerRadius = 36
        tableBackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        addTransitionView()
        
        homeService = HomeService()
        
        queryUserData()
        queryTopUserData()
        
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
            let electricityItems = data["electricity"]! as? [[String]]
            let heatingItems = data["heating"]! as? [[String]]
            let saved = data["saved"] as? [[String]]
            
            for item in electricityItems! {
                items.append(ChartItem(month: item[0], value: item[1]))
            }
            
            self.charts.append(CompletedChart(title: "Power per Month", keyvalue: "electricity", valuePairs: items))
            items.removeAll()
            
            for item in heatingItems! {
                items.append(ChartItem(month: item[0], value: item[1]))
            }
            
            self.charts.append(CompletedChart(title: "Heating energy per Month", keyvalue: "heating", valuePairs: items))
            items.removeAll()
            
            for item in saved! {
                items.append(ChartItem(month: item[0], value: item[1]))
            }
            
            self.charts.append(CompletedChart(title: "Saved energy per Month", keyvalue: "saved", valuePairs: items))
            items.removeAll()
            
            self.dashboardTableView.reloadData()
            
        })
    }
    
    func queryTopUserData() {
        homeService.performTopQuery(completion: { (data, state) -> Void in
            
            let items = data as? [String : String]
            self.titleValueLabel.text = items?["daily_usage"]
            self.leftValueLabel.text = items?["monthly_independence"]
            self.rightValueLabel.text = items?["monthly_usage"]
            
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
    
    func convertArray(array: [String]) -> [Double]{
        
        //load array into one string
        let joiner = " "
        let joinedStrings = array.joined(separator: joiner)
        
        //load string into new array
        let dotArray = joinedStrings.split{$0 == " "}.map(String.init)
        
        //convert into double array
        let doubleArray = dotArray.compactMap(Double.init)
        return doubleArray
    }
    
    func setChartValues(array: [String], name: String) -> BarChartData{
        
        let values = (0..<array.count).map { (i) -> ChartDataEntry in
            let val = convertArray(array: array)[i]
            return BarChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = BarChartDataSet(entries: values, label: name)
        
        
        set1.setColors(UIColor.init(named: "ButtonGreen")!)
        set1.valueFont = UIFont.init(name: "Avenir Next", size: 12)!
        set1.valueTextColor = UIColor.init(named: "TextWhite")!
        
        let data = BarChartData(dataSet: set1)
        
        return data
        
    }

}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell", for: indexPath) as? DashboardTableViewCell else { return DashboardTableViewCell() }
        
        cell.chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        //get value pairs
        var months = [String]()
        var values = [String]()
        for item in charts[indexPath.row].valuePairs {
            months.append(item.month)
            values.append(item.value)
        }
        
        cell.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        cell.chartView.xAxis.granularity = 1
        
        cell.chartView.data = setChartValues(array: values, name: charts[indexPath.row].title)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    

    
}

