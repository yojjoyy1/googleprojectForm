//
//  GoogleFormModel.swift
//  表單管理
//
//  Created by 林信沂 on 2020/12/22.
//

import Foundation
import UIKit
struct GoogleFormModel:Codable {
    var formName:String?
    var productArr:[String]?
    var specificationArr:[String]?
    var numStart:Int?
    var numEnd:Int?
    var type:Int?
    var publishUrl:String?
    var editUrl:String?
    var summaryUrl:String?
    var wOder:String?
    var size:String?
    var count:String?
    var name:String?
    var phone:String?
    var address:String?
    var email:String?
    var remark:String?
    var id:String?
    var date:String?
}
extension GoogleFormModel {
    func convertToDict() -> NSDictionary? {
        var dict: NSDictionary? = nil
        do {
            print("init student")
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            print("struct convert to data")
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
        } catch {
            print(error)
        }
        return dict
    }
}

