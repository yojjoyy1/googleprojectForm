//
//  ViewModel.swift
//  表單管理
//
//  Created by 林信沂 on 2020/12/22.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController{
    func showIndicator(withTitle title: String, description:String){
        let indicator = MBProgressHUD.showAdded(to: self.navigationController!.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = description
        indicator.show(animated: true)
        indicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: self.navigationController!.view, animated: true)
    }
}
protocol ViewModelDelegate{
    func googleResponse(modelArr:[GoogleFormModel])
}
protocol ViewModelInterface {
    var delegate:ViewModelDelegate? { get set }
    func getGoogleForm(arr:NSArray,myType:Int)
}
class ViewModel:NSObject,ViewModelInterface,UICollectionViewDelegate,UICollectionViewDataSource{
    
    static let sharedInstance = ViewModel()
    var delegate: ViewModelDelegate?
    var dataArr = [GoogleFormModel]()
    var homeCollV:HomeCollectionView!
    let refreshControl = UIRefreshControl()
    var viewModelBindVc:UIViewController!
    var currentFormDataArr = [GoogleFormModel]()
    func bindCollV(view:UIView,vc:UIViewController){
        if homeCollV == nil{
            viewModelBindVc = vc
            let collectionViewLayOut = UICollectionViewFlowLayout()
            collectionViewLayOut.minimumInteritemSpacing = 10
            collectionViewLayOut.minimumLineSpacing = 10
            collectionViewLayOut.scrollDirection = .vertical
            collectionViewLayOut.itemSize = CGSize(width: (view.frame.size.width * 0.5) - 20, height: (view.frame.size.width * 0.5) - 20)
            homeCollV = HomeCollectionView(frame: .zero, collectionViewLayout: collectionViewLayOut)
            homeCollV.setAutoLayOut(view: view)
            refreshControl.addTarget(self, action: #selector(getFormList), for: .valueChanged)
            homeCollV.refreshControl = refreshControl
            homeCollV.delegate = self
            homeCollV.dataSource = self
        }
    }
    @objc func goAddFormPage(){
        viewModelBindVc.navigationController!.pushViewController(AddFormViewController.sharedInstance, animated: true)
    }
    @objc func addForm(){
        
        let googleModel = GoogleFormModel(formName: "test", productArr: ["排骨便當 50/60元","雞腿便當 60/70元"], specificationArr: ["小","大"], numStart: 1, numEnd: 10, type: 1, publishUrl: nil, editUrl: nil, summaryUrl: nil, wOder: nil, size: nil, count: nil, name: nil, phone: nil, address: nil, email: nil, remark: nil, id: nil, date: nil).convertToDict()
        ApiModel.sharedInstance.sendApi(urlStr: "\(ApiModel.sharedInstance.domain)\(ApiModel.sharedInstance.googleFormPath)", method: .post, pars: googleModel) { (resErr, resData) in
            if resErr != nil{
                print("addForm err:\(resErr!.localizedDescription)")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: resData!, options: [])
                    let arr = json as! NSArray
                    print("getFormList google回應:\(arr)")
                    self.getGoogleForm(arr: arr, myType: 1)
                }catch{
                    let str = String.init(data: resData!, encoding: .utf8)
                    print("ViewModel getFormList回應解析錯誤 err:\(error.localizedDescription) str:\(str)")
                }
            }
        }
    }
    @objc func getFormList(){
        viewModelBindVc.showIndicator(withTitle: "正在搜尋...", description: "")
        homeCollV.refreshControl?.beginRefreshing()
        let dic:NSDictionary = ["type":2]
        ApiModel.sharedInstance.sendApi(urlStr: "\(ApiModel.sharedInstance.domain)\(ApiModel.sharedInstance.googleFormPath)", method: .post, pars: dic) { (resErr, resData) in
            if resErr != nil{
                mainQueue.async {
                    self.homeCollV.refreshControl?.endRefreshing()
                    self.viewModelBindVc.hideIndicator()
                }
                print("getFormList resErr:\(resErr!.localizedDescription)")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: resData!, options: [])
                    let arr = json as! NSArray
                    print("getFormList google回應:\(arr)")
                    self.getGoogleForm(arr: arr, myType: 2)
                }catch{
                    let str = String.init(data: resData!, encoding: .utf8)
                    print("ViewModel getFormList回應解析錯誤 err:\(error.localizedDescription) str:\(str)")
                }
            }
        }
    }
    func setFormDetailModel(modelArr:[GoogleFormModel]){
        for i in 0...modelArr.count - 1{
            let modelDic = modelArr[i].convertToDict()
            let wOder = modelDic!["wOder"] as! String
            let size = modelDic!["size"] as! String
            let count = modelDic!["count"] as! String
            let name = modelDic!["name"] as! String
            let phone = modelDic!["phone"] as! String
            let address = modelDic!["address"] as! String
            let email = modelDic!["email"] as! String
            let remark = modelDic!["remark"] as! String
            let formDetail = FormDetailModel(wOder: wOder, size: size, count: count, name: name, email: email, remark: remark, phone: phone, address: address)
            FormDetailViewController.sharedInstance.setDetailModel(setModel: formDetail)
        }
        mainQueue.async {
            self.viewModelBindVc.navigationController?.pushViewController(FormDetailViewController.sharedInstance, animated: true)
        }
    }
    //MARK:ViewModelInterface
    func getCurrentFormData(id:String){
        viewModelBindVc.showIndicator(withTitle: "正在搜尋...", description: "")
        homeCollV.refreshControl?.beginRefreshing()
        let dic:NSDictionary = ["type":0,"id":id]
        ApiModel.sharedInstance.sendApi(urlStr: "\(ApiModel.sharedInstance.domain)\(ApiModel.sharedInstance.googleFormPath)", method: .post, pars: dic) { (resErr, data) in
            if resErr != nil{
                print("resErr:\(resErr!.localizedDescription)")
                mainQueue.async {
                    self.viewModelBindVc.hideIndicator()
                }
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let arr = json as! NSArray
                    print("google回應:\(arr)")
                    self.getGoogleForm(arr: arr, myType: 0)
                }catch{
                    let str = String.init(data: data!, encoding: .utf8)
                    print("ViewModel回應解析錯誤 err:\(error.localizedDescription) str:\(str)")
                    mainQueue.async {
                        self.viewModelBindVc.hideIndicator()
                    }
                }
            }
        }
    }
    func getGoogleForm(arr: NSArray,myType:Int) {
//        print("type:\(myType)")
        if myType == 2{
            dataArr.removeAll()
        }else if myType == 0{
            currentFormDataArr.removeAll()
        }
        if arr.count > 0{
            for i in 0...arr.count - 1{
                let dic = arr[i] as! NSDictionary
                var formName:String?
                var publishUrl:String?
                var editUrl:String?
                var summaryUrl:String?
                var productArr:[String]?
                var specificationArr:[String]?
                var numStart:Int?
                var numEnd:Int?
                var type:Int?
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
                for (key,value) in dic{
                    if key as! String == "formName"{
                        formName = (value as! String)
                    }else if key as! String == "publishUrl"{
                        publishUrl = (value as! String)
                    }else if key as! String == "editUrl"{
                        editUrl = (value as! String)
                    }else if key as! String == "summaryUrl"{
                        summaryUrl = (value as! String)
                    }else if key as! String == "productArr"{
                        productArr = (value as! [String])
                    }else if key as! String == "specificationArr"{
                        specificationArr = (value as! [String])
                    }else if key as! String == "numStart"{
                        numStart = (value as! Int)
                    }else if key as! String == "numEnd"{
                        numEnd = (value as! Int)
                    }else if key as! String == "type"{
                        type = (value as! Int)
                    }else if key as! String == "要訂什麼?"{
                        wOder = (value as! String)
                    }else if key as! String == "大小"{
                        size = (value as! String)
                    }else if key as! String == "選擇數量"{
                        count = (value as! String)
                    }else if key as! String == "姓名"{
                        name = (value as! String)
                    }else if key as! String == "電話"{
                        phone = (value as! String)
                    }else if key as! String == "信箱"{
                        print("email:\(value)")
                        email = (value as! String)
                    }else if key as! String == "地址"{
                        address = (value as! String)
                    }else if key as! String == "備註"{
                        remark = (value as! String)
                    }else if key as! String == "id"{
                        id = (value as! String)
                    }else if key as! String == "date"{
                        date = (value as! String)
                    }
                }
                let googleFormModel = GoogleFormModel(formName: formName, productArr: productArr, specificationArr: specificationArr, numStart: numStart, numEnd: numEnd, type: type, publishUrl: publishUrl, editUrl: editUrl, summaryUrl: summaryUrl, wOder: wOder, size: size, count: count, name: name, phone: phone, address: address, email: email, remark: remark,id: id,date: date)
                if myType == 2{
//                    print("googleFormModel:\(googleFormModel)")
                    dataArr.append(googleFormModel)
                }else if myType == 0{
                    currentFormDataArr.append(googleFormModel)
                }
            }
        }
        mainQueue.async {
            if myType == 2{
                self.homeCollV.refreshControl?.endRefreshing()
                self.viewModelBindVc.hideIndicator()
                self.delegate?.googleResponse(modelArr: self.dataArr)
            }else if myType == 0{
                self.viewModelBindVc.hideIndicator()
//                print("currentFormDataArr:\(self.currentFormDataArr)")
                self.setFormDetailModel(modelArr: self.currentFormDataArr)
            }
        }
    }
    
    //MARK:CollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("count:\(dataArr.count)")
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArr[indexPath.row]
        getCurrentFormData(id: model.id!)
//        print("model:\(model)")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let data = dataArr[indexPath.row]
//        print("data:\(data)")
        cell.setUp(text: "\(data.formName!)\n\(data.date!)")
        return cell
    }
}
