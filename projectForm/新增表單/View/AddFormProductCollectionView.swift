//
//  AddFormProductCollectionView.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/27.
//

import UIKit

class AddFormProductCollectionView: UICollectionView,TextFieldChangeDelegate {
    
    
    var layoutWidth:NSLayoutConstraint!
    var sectionName:String!
    var arr = [String]()
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(AddFormProductCollectionViewCell.self, forCellWithReuseIdentifier: "AddFormProductCollectionViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNum), name: NSNotification.Name(rawValue: "deleteItem"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setAutoLayOut(mainView:UIView,width:Int){
        self.backgroundColor = .white
        mainView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: mainView, attribute: .leading, multiplier: 1.0, constant: 10)
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: mainView, attribute: .top, multiplier: 1.0, constant: 10)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: mainView, attribute: .bottom, multiplier: 1.0, constant: -10)
//        let widthConstant = CGFloat((num! * width) < (Int(mainView.frame.size.width) - width) ? (num!*width):(num!-1 * width))
        let widthConstant = CGFloat(arr.count * width)
//        print("widthConstant:\(widthConstant)")
        layoutWidth = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: widthConstant)
        mainView.addConstraints([leading,top,bottom,layoutWidth])
    }
    func setNum(width:CGFloat,name:String){
        if name == sectionName{
            arr.append("")
            if (CGFloat(arr.count) * width * 2) < ((width * 8)+10){
                layoutWidth.constant = CGFloat(arr.count * Int(width) * 2)
            }
            reloadData()
        }
//        print("name:\(name) setNum:\(num!)")
    }
    func getNum() -> Int{
        return arr.count
    }
    @objc func deleteNum(notification:Notification){
        let object = notification.object as! NSDictionary
        let name = object["sectionName"] as! String
        let textfield = object["textfield"] as! MyTextField
        if name == sectionName{
            print("whichNum:\(textfield.whichNum)")
            arr.remove(at: textfield.whichNum)
            textfield.text = ""
//            print("arr:\(arr) name:\(name)")
            if name == "要訂什麼?"{
                AddFormViewController.sharedInstance.addFormModel.productArr = arr
            }else if name == "大小規格"{
                AddFormViewController.sharedInstance.addFormModel.specificationArr = arr
            }
            reloadData()
        }
    }
    //MARK:TextFieldChangeDelegate
    func textChange(textField: MyTextField) {
        print("textChange textFieldSectionName:\(textField.sectionName) sectionName:\(sectionName)")
        if textField.sectionName! == sectionName!{
            let which = textField.whichNum
            if sectionName == "要訂什麼?" && arr.count > 0{
                arr[which!] = textField.text!
//                print("productArr:\(AddFormViewController.sharedInstance.addFormModel.productArr) arr:\(arr)")
                AddFormViewController.sharedInstance.addFormModel.productArr = arr
            }else if sectionName == "要訂什麼?" && arr.count == 0{
                AddFormViewController.sharedInstance.addFormModel.productArr = [String]()
            }else if sectionName == "大小規格" && arr.count > 0{
                arr[which!] = textField.text!
                AddFormViewController.sharedInstance.addFormModel.specificationArr = arr
            }else if sectionName == "大小規格" && arr.count == 0{
                AddFormViewController.sharedInstance.addFormModel.specificationArr = [String]()
            }
        }
    }
}
