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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
