//
//  AddFormModel.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/27.
//

import Foundation

struct AddFormModel:Codable{
    static var sharedInstance = AddFormModel()
    var type:Int? = nil
    var formName:String? = ""
    var productArr:[String]? = [String]()
    var specificationArr:[String]? = [String]()
    var numStart:Int? = nil
    var numEnd:Int? = nil
}
extension AddFormModel {
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
