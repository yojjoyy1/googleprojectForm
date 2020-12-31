//
//  ApiModel.swift
//  表單管理
//
//  Created by 林信沂 on 2020/12/22.
//

import Foundation
let mainQueue = DispatchQueue.main
enum MyMethod:String {
    case get = "GET"
    case post = "POST"
}
struct ApiModel {
    static let sharedInstance = ApiModel()
    let domain = "https://us-central1-line-7b18b.cloudfunctions.net/"
    let googleFormPath = "googleForm"
    func sendApi(urlStr:String,method:MyMethod,pars:NSDictionary?,complete:@escaping(Error?,Data?) -> ()){
        let url = URL(string: urlStr)!
        var request = URLRequest(url: url)
        if method.rawValue == "POST"{
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do{
//                print("pars:\(pars)")
                let jsonData = try JSONSerialization.data(withJSONObject: pars!, options: [])
                request.httpBody = jsonData
            }catch{
                print("json轉換data失敗 err:\(error.localizedDescription)")
            }
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (resData, res, err) in
            complete(err,resData)
        }
        task.resume()
    }
}
