//
//  FormDetailViewController.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/30.
//

import UIKit
import Charts
class FormDetailViewController: UIViewController,UIScrollViewDelegate {

    static let sharedInstance = FormDetailViewController()
    var customChatsView:CustomChatsView!
    var scrollView:FormDetailScrollView!
    var formDetailTableView:FormDetailTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "表單詳細"
        self.view.backgroundColor = .white
        FormDetailViewModel.sharedInstance.bindVc = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let rect = CGRect(x: 0, y: (self.navigationController!.navigationBar.frame.origin.y) + (self.navigationController!.navigationBar.frame.size.height), width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.origin.y + self.navigationController!.navigationBar.frame.size.height))
        if scrollView == nil{
            scrollView = FormDetailScrollView()
            scrollView.delegate = self
            scrollView.setUp(mainView: self.view, rect: rect)
            formDetailTableView = FormDetailTableView(frame: CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
            scrollView.addSubview(formDetailTableView)
        }
        if customChatsView == nil{
            customChatsView = CustomChatsView()
            customChatsView.setUp(mainView: scrollView)
            scrollView.addSubview(customChatsView)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if customChatsView != nil{
            customChatsView.customizeChart(dataPoints: FormDetailViewModel.sharedInstance.modelResult.0, values: FormDetailViewModel.sharedInstance.modelResult.1)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FormDetailViewModel.sharedInstance.detailArr.removeAll()
    }
    func setDetailModel(setModel:FormDetailModel){
        FormDetailViewModel.sharedInstance.detailArr.append(setModel)
        FormDetailViewModel.sharedInstance.getPieChartViewData()
    }
    

}
