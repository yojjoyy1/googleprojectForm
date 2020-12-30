//
//  AddFormViewModel.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/27.
//

import Foundation
import UIKit
protocol AddFormViewModelDelegate{
    func changeCollV()
    func deleteCollVItem()
    func sendAddForm()
}
@objc protocol TextFieldChangeDelegate:NSObjectProtocol {
    @objc func textChange(textField:MyTextField)
}
protocol AddFormViewModelInterface {
    var addFormDelegate:AddFormViewModelDelegate? { get set }
}
class AddFormViewModel: NSObject,UITableViewDelegate,UITableViewDataSource,AddFormViewModelInterface {
    var addFormDelegate: AddFormViewModelDelegate?
    
    static let sharedInstance = AddFormViewModel()
    var sectionTitleArr = ["表單名稱","要訂什麼?","大小規格","選擇數量範圍"]
    var tableV:AddFormTableView!
    func setUp(mainView:UIView){
        if tableV == nil{
            tableV = AddFormTableView(frame: .zero, style: .plain)
            tableV.setAutoLayout(view: mainView)
            tableV.delegate = self
            tableV.dataSource = self
        }
    }
    //MARK:UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleArr.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArr[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionTitleArr[section] == "選擇數量範圍"{
            return 2
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.width * 0.2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableV.dequeueReusableCell(withIdentifier: "AddFormTableViewCell", for: indexPath) as! AddFormTableViewCell
        cell.backgroundColor = .white
        if indexPath.section == 1 || indexPath.section == 2{
            cell.setup(sectionName: sectionTitleArr[indexPath.section])
        }else if indexPath.section == 0{
            cell.setUpHasTextField(currentSectionName: sectionTitleArr[indexPath.section], inputPickView: false,row: indexPath.row)
        }else if indexPath.section == 3{
            cell.setUpHasTextField(currentSectionName: sectionTitleArr[indexPath.section], inputPickView: true,row: indexPath.row)
        }
        return cell
    }
}
