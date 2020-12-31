//
//  CustomChatsView.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/30.
//

import UIKit
import Charts
class CustomChatsView: UIView {
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    var pieChartView:PieChartView!
//    static let sharedInstance = CustomChatsView()
    func setUp(mainView:FormDetailScrollView){
        self.frame = CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height)
        if pieChartView == nil{
            pieChartView = PieChartView()
            //分類的文字顏色
            pieChartView.legend.textColor = .black
            pieChartView.legend.formSize = 25
            pieChartView.entryLabelColor = .red
            pieChartView.delegate = FormDetailViewModel.sharedInstance
            let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(23.0)), NSAttributedString.Key.foregroundColor: UIColor.red]
            let centerTextAttribute = NSAttributedString(string: "幾單\n品項", attributes: attributes)
            pieChartView.centerAttributedText = centerTextAttribute
            self.addSubview(pieChartView)
            pieChartView.translatesAutoresizingMaskIntoConstraints = false
        }
        let pieleading = NSLayoutConstraint(item: pieChartView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let pietop = NSLayoutConstraint(item: pieChartView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let piebottom = NSLayoutConstraint(item: pieChartView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pietrailing = NSLayoutConstraint(item: pieChartView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        self.addConstraints([pieleading,pietop,piebottom,pietrailing])
    }
    func customizeChart(dataPoints: [String], values: [Double]){
//        print("customizeChart dataPoints:\(dataPoints) values:\(values)")
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
          // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        pieChartDataSet.entryLabelFont = .boldSystemFont(ofSize: 18)
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        pieChartData.setValueFont(.boldSystemFont(ofSize: 18))
        pieChartData.setValueTextColor(.red)
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
    }
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
      for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
      }
      return colors
    }

}
