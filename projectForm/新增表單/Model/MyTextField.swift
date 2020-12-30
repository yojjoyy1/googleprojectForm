//
//  MyTextField.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/28.
//

import UIKit

class MyTextField: UITextField,UITextFieldDelegate {

    var pickView:UIPickerView!
    var row:Int!  //pickView row
    var whichNum:Int!
    var changeDelegate:TextFieldChangeDelegate!
    var sectionName:String!
    var collV:AddFormProductCollectionView!
    @objc func pickViewCancel(){
        self.resignFirstResponder()
    }
    func setUp(inputPickView:Bool,pickDelegate:UIPickerViewDelegate?,pickDataSource:UIPickerViewDataSource?,setChangeDelegate:TextFieldChangeDelegate?,setSectionName:String){
        changeDelegate = setChangeDelegate == nil ? nil:setChangeDelegate!
//        print("setUp changeDelegate:\(changeDelegate)")
        sectionName = setSectionName
        self.delegate = self
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.textColor = .black
        self.autocorrectionType = .no
        if inputPickView{
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()

            let doneButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: self, action: #selector(pickViewCancel))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "取消", style: UIBarButtonItem.Style.plain, target: self, action: #selector(pickViewCancel))

            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            if pickView == nil{
                pickView = UIPickerView()
                NotificationCenter.default.addObserver(self, selector: #selector(pickViewNotification(notification:)), name: Notification.Name(rawValue: "pickViewNotification"), object: nil)
                pickView.delegate = pickDelegate
                pickView.dataSource = pickDataSource
            }
            self.inputView = pickView
            self.inputAccessoryView = toolBar
        }else{
            self.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
            self.becomeFirstResponder()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    //MARK:Notification
    @objc func pickViewNotification(notification:Notification){
        let object = notification.object as! NSDictionary
        let objectRow = object["row"] as! Int
//        print("pickViewNotification row:\(row),objectRow:\(objectRow)")
        if objectRow == row{
            self.text = object["numStr"] as? String
            if row == 0{
                AddFormViewController.sharedInstance.addFormModel.numStart = Int(self.text!)!
//                print("pickViewNotification numStart:\(AddFormModel.sharedInstance.numStart)")
            }else{
                AddFormViewController.sharedInstance.addFormModel.numEnd = Int(self.text!)!
//                print("pickViewNotification numEnd:\(AddFormViewController.sharedInstance.addFormModel.numEnd)")
            }
        }
    }
    @objc func textFieldDidChange(){
        if changeDelegate != nil && changeDelegate!.responds(to: #selector(changeDelegate!.textChange(textField:))){
            print("有實作changeDelegate")
            changeDelegate.textChange(textField: self)
        }else{
            print("沒有實作changeDelegate")
            if self.sectionName == "表單名稱"{
                AddFormViewController.sharedInstance.addFormModel.formName = self.text!
            }
        }
        print("textFieldDidChange str:\(self.text)")
    }

}
