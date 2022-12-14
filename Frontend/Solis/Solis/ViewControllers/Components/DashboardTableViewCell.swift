//
//  DashboardTableViewCell.swift
//  Solis
//
//  Created by Julian Waluschyk on 18.11.22.
//

import UIKit
import Charts

class DashboardTableViewCell: UITableViewCell {

    @IBOutlet weak var barContentView: UIView!
    @IBOutlet weak var chartView: BarChartView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        barContentView.layer.cornerRadius = 30
        barContentView.layer.masksToBounds = true
        
        self.chartView.gridBackgroundColor = UIColor.init(named: "ChartColor")!
        
        self.chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .easeInSine)
        self.chartView.rightAxis.enabled = false
        
        self.chartView.leftAxis.labelFont = UIFont.init(name: "Avenir Next", size: 10)!
        self.chartView.xAxis.labelFont = UIFont.init(name: "Avenir Next", size: 10)!
        self.chartView.leftAxis.labelTextColor = UIColor.init(named: "TextWhite")!
        self.chartView.xAxis.labelTextColor = UIColor.init(named: "TextWhite")!
        
       self.chartView.legend.font = UIFont.init(name: "Avenir Next", size: 12)!
//        self.chartView.legend.textColor = UIColor.init(named: "textColor")!
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
