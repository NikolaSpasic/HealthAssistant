//
//  StatsVC.swift
//  HealthAssistant
//
//  Created by Slavimir Stosovic on 9/16/19.
//  Copyright © 2019 VTS AppsTeam. All rights reserved.
//

import UIKit
import Charts

class StatsVC: UIViewController {
    @IBOutlet weak var pieChart: PieChartView!
    var activityNames = [String]()
    var activityTimes = [Int]()
    var api = API.instance
    let time = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var activityTime = 15
        for activity in api.activities {
            if activity.name != "Ukupno" {
                activityNames.append(activity.name)
                activityTimes.append(activityTime)
                activityTime += 5
            }
        }
        customizeChart(names: activityNames, values: activityTimes.map{ Double($0) })
    }
    
    func customizeChart(names: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<names.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: names[i], data: names[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = [NSUIColor(cgColor: UIColor(red: 223/255, green: 61/255, blue: 61/255, alpha: 1).cgColor), NSUIColor(cgColor: UIColor(red: 22/255, green: 160/255, blue: 133/255, alpha: 1).cgColor), NSUIColor(cgColor: UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1).cgColor), NSUIColor(cgColor: UIColor(red: 200/255, green: 150/255, blue: 10/255, alpha: 1).cgColor), NSUIColor(cgColor: UIColor(red: 211/255, green: 84/255, blue: 0/255, alpha: 1).cgColor), NSUIColor(cgColor: UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha: 1).cgColor)]
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        pieChart.data = pieChartData
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
