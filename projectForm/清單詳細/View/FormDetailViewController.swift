//
//  FormDetailViewController.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/30.
//

import UIKit
import Charts
class FormDetailViewController: UIViewController {

    static let sharedInstance = FormDetailViewController()
    var detailArr = [FormDetailModel]()
    var customChatsView:CustomChatsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        customChatsView = CustomChatsView()
//        customChatsView.setUp(mainView: self.view)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customChatsView.setUp(mainView: self.view)
    }
    func setDetailModel(setModel:FormDetailModel){
        detailArr.append(setModel)
        print("setDetailModel detailArr:\(detailArr)")
    }
    

}
