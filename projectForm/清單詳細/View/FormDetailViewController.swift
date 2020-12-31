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
    var detailArr = [FormDetailModel]()
    var customChatsView:CustomChatsView!
    var scrollView:FormDetailScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "表單詳細"
        self.view.backgroundColor = .white
//        customChatsView.setUp(mainView: self.view)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        detailArr.removeAll()
    }
    func setDetailModel(setModel:FormDetailModel){

        if scrollView == nil{
            scrollView = FormDetailScrollView()
            scrollView.delegate = self
            scrollView.setUp(mainView: self.view)
            let v2 = UIView(frame: CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            v2.backgroundColor = .red
            scrollView.addSubview(v2)
        }
        if customChatsView == nil{
            customChatsView = CustomChatsView()
            customChatsView.backgroundColor = .gray
            customChatsView.setUp(mainView: scrollView)
            scrollView.addSubview(customChatsView)
        }
        detailArr.append(setModel)
        let result = FormDetailViewModel.sharedInstance.getPieChartViewData(detailArr: detailArr)
        if customChatsView != nil{
            customChatsView.customizeChart(dataPoints: result.0, values: result.1)
        }
//        print("setDetailModel result:\(result)")
//        print("setDetailModel detailArr:\(detailArr)")
    }
    

}
