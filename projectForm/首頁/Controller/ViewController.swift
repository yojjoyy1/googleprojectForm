//
//  ViewController.swift
//  表單管理
//
//  Created by 林信沂 on 2020/12/22.
//

import UIKit

class ViewController: UIViewController,ViewModelDelegate {
    
    static let sharedInstance = ViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewModel.sharedInstance.delegate = self
        ViewModel.sharedInstance.bindCollV(view: self.view, vc: self)
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: .plain, target: ViewModel.sharedInstance, action: #selector(ViewModel.sharedInstance.goAddFormPage))
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(backAction))
        self.navigationItem.rightBarButtonItem?.tintColor = .red
        ViewModel.sharedInstance.getFormList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        ViewModel.sharedInstance.postType0()
    }
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:ViewModelDelegate
    func googleResponse(modelArr: [GoogleFormModel]) {
        print("googleResponse modelArr:\(modelArr)")
        mainQueue.async {
            ViewModel.sharedInstance.homeCollV.reloadData()
        }
    }
    

}

