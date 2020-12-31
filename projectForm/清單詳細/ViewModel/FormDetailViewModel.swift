//
//  FormDetailViewModel.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/31.
//

import Foundation
import UIKit
import Charts
class FormDetailViewModel:NSObject,UITableViewDataSource,UITableViewDelegate,ChartViewDelegate {
    
    static let sharedInstance = FormDetailViewModel()
    var modelResult:([String],[Double])!
    var bindVc:UIViewController!
    var detailArr = [FormDetailModel]()
    func getPieChartViewData(){
        let pieChartData = NSMutableDictionary()
        for i in 0...detailArr.count - 1{
            let formDetailModel = detailArr[i]
            let wOder = formDetailModel.wOder!
            let count = formDetailModel.count!
//            print("wOder:\(wOder) count:\(count) i:\(i)")
            if pieChartData[wOder] == nil{
                pieChartData[wOder] = Int(count)!
            }else{
                pieChartData[wOder] = (pieChartData[wOder] as! Int) + Int(count)!
            }
//            print("pieChartData:\(pieChartData)")
        }
        var valueArr = [Double]()
        for (_,value) in pieChartData{
            valueArr.append(value as! Double)
        }
        let allKeys = pieChartData.allKeys as! [String]
        modelResult = (allKeys,valueArr)
//        print("pieChartData end:\(pieChartData)")
    }
    //MARK:UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArr.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height * 0.5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormDetailTableViewCell", for: indexPath) as! FormDetailTableViewCell
        let detail = detailArr[indexPath.row]
        cell.setUp(model: detail,indexRow: indexPath.row)
        return cell
    }
    //MARK:ChartViewDelegate
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

//        print("chartValueSelected x:\(modelResult.0[Int(highlight.x)]),y:\(Int(highlight.y))單")
        let alertC = UIAlertController(title: "品項:\(modelResult.0[Int(highlight.x)])", message: "\(Int(highlight.y))單", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        alertC.addAction(alertAction)
        bindVc.present(alertC, animated: true, completion: nil)
        
    }
}
