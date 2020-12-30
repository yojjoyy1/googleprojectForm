//
//  AddFormViewController.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/27.
//

import UIKit
//import MBProgressHUD
class AddFormViewController: UIViewController {

    static let sharedInstance = AddFormViewController()
    var addFormModel = AddFormModel(type: nil, formName: nil, productArr: nil, specificationArr: nil, numStart: nil, numEnd: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "新增表單"
        self.view.backgroundColor = .white
        AddFormViewModel.sharedInstance.setUp(mainView: self.view)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "send"), style: .plain, target: self, action: #selector(addNewGoogleFormAction))
        self.navigationItem.rightBarButtonItem?.tintColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AddFormViewModel.sharedInstance.tableV.layoutIfNeeded()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc func addNewGoogleFormAction(){
        addFormModel.type = 1
        let dic = addFormModel.convertToDict()
        self.showIndicator(withTitle: "資料傳送中", description: "")
        ApiModel.sharedInstance.sendApi(urlStr: "\(ApiModel.sharedInstance.domain)\(ApiModel.sharedInstance.googleFormPath)", method: .post, pars: dic) { (error, data) in
            if error != nil{
                print("error:\(error?.localizedDescription)")
            }else{
                do{
                    self.navigationController?.popViewController(animated: true)
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print("json:\(json)")
                }catch{
                    let str = String.init(data: data!, encoding: .utf8)
                    print("json errStr:\(str!)")
                }
            }
            mainQueue.async {
                self.hideIndicator()
            }
        }
        print("addNewGoogleFormAction dic:\(dic!)")
    }

}
