//
//  FormDetailViewModel.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/31.
//

import Foundation

class FormDetailViewModel:NSObject {
    
    static let sharedInstance = FormDetailViewModel()
    func getPieChartViewData(detailArr:[FormDetailModel]) -> ([String],[Double]){
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
//        print("pieChartData end:\(pieChartData)")
        return (allKeys,valueArr)
    }
}
