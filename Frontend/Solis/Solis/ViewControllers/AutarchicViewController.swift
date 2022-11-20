//
//  AutarchicViewController.swift
//  Solis
//
//  Created by Julian Waluschyk on 19.11.22.
//

import UIKit
import Charts

class AutarchicViewController: UIViewController {

    @IBOutlet weak var tableBackView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var transitionView: UIView!
    
    var autarchicService: AutarchicService!
    
    struct ChartItem {
        var month: String
        var value: String
    }
    
    struct Graph {
        var valuePairs: [ChartItem]
        var name: String
    }
    
    struct CompletedChart {
        var graphs: [Graph]
        var title: String
        var keyvalue: String
    }
    
    var charts = [CompletedChart]()
    var lineColors = [UIColor.init(named: "LineColorGreen"), UIColor.init(named: "LineColorBrown"), UIColor.init(named: "LineColorBlue"), UIColor.init(named: "LineColorPurple"), UIColor.init(named: "LineColorTurkis"), UIColor.init(named: "ButtonGreen")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //corner radius
        tableBackView.clipsToBounds = true
        tableBackView.layer.cornerRadius = 36
        tableBackView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        autarchicService = AutarchicService()
        
        addTransitionView()
        
        performFriendQuery()
        performGlobalQuery()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showTransitionView),
                                               name:Notification.Name("ADD_TRANSITIONVIEW"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(removeTransitionView),
                                               name:Notification.Name("REMOVE_TRANSITIONVIEW"),
                                               object: nil)
        
    }
    
    func performFriendQuery() {
        autarchicService.performFriendQuery(completion: { (data, state) -> Void in
            
            var points = [ChartItem]()
            var items = [Graph]()
            
            for name in data.keys {
                let friendsData = data[name] as? [[String]]
                for item in friendsData! {
                    points.append(ChartItem(month: item[0], value: item[1]))
                }
                items.append(Graph(valuePairs: points, name: name))
                points.removeAll()
            }
            
            self.charts.append(CompletedChart(graphs: items, title: "Compare with friends", keyvalue: "friends"))
            
            self.tableView.reloadData()
            
        })
    }
    
    func performGlobalQuery() {
        autarchicService.performGlobalQuery(completion: { (data, state) -> Void in
            
            var points = [ChartItem]()
            var items = [Graph]()
            
            for name in data.keys {
                let globalData = data[name] as? [[String]]
                for item in globalData! {
                    points.append(ChartItem(month: item[0], value: item[1]))
                }
                items.append(Graph(valuePairs: points, name: name))
                points.removeAll()
            }
            
            self.charts.append(CompletedChart(graphs: items, title: "Compare to users worldwide", keyvalue: "global"))
            
            self.tableView.reloadData()
            
        })
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
    
    func setChartValues(array: [Graph]) -> LineChartData {
        
        var sets = [LineChartDataSet]()
        
        var counter = 0
        for graph in array {
            var items = [String]()
            for item in graph.valuePairs {
                items.append(item.value)
            }
            let values = (0..<array.count).map { (i) -> ChartDataEntry in
                let val = convertArray(array: items)[i]
                return ChartDataEntry(x: Double(i), y: val)
            }
            
            let set1 = LineChartDataSet(entries: values, label: graph.name)

            set1.circleColors = [lineColors[counter]!] as! [NSUIColor]
            set1.fillColor = lineColors[counter]!
            if graph.name == "You" {
                set1.lineWidth = 4.0
                set1.circleRadius = 10.0
            } else {
                set1.lineWidth = 2.0
            }
            
            set1.setColors(lineColors[counter]!)
            set1.circleHoleColor = UIColor.init(named: "MainGreenLight")
            set1.valueFont = UIFont.init(name: "Avenir Next", size: 12)!
            set1.valueTextColor = UIColor.init(named: "TextWhite")!
            set1.mode = .linear
            
            sets.append(set1)
            counter = counter + 1
        }
        
        
        let data = LineChartData(dataSets: sets)
        
        return data
        
    }
    
    @objc func addTransitionView() {
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
    
    @objc func removeTransitionView() {
        transitionView.isHidden = true
    }
    
    @objc func showTransitionView() {
        transitionView.isHidden = false
    }
    
}

extension AutarchicViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autarchicCell", for: indexPath) as? AutarchicTableViewCell
        
        cell!.chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        //get graphs
        var months = [String]()
        for item in charts[indexPath.row].graphs {
            for month in item.valuePairs {
                months.append(month.month)
            }
            break
        }
        
        cell!.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        cell!.chartView.xAxis.granularity = 1
        
        cell!.chartView.data = setChartValues(array: charts[indexPath.row].graphs)
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

