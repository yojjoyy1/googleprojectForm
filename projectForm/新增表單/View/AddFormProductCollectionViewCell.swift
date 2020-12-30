//
//  AddFormProductCollectionViewCell.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/27.
//

import UIKit

class AddFormProductCollectionViewCell: UICollectionViewCell {
    var textfield:MyTextField!
    var cancelBtn:UIButton!
    var sectionName:String!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setAutoLayOut(name:String,currentStr:String,whichNum:Int,changeDelegate:TextFieldChangeDelegate){
        if textfield == nil{
            sectionName = name
            textfield = MyTextField()
            textfield.textColor = .black
            textfield.text = currentStr
            textfield.setUp(inputPickView: false,pickDelegate: nil,pickDataSource: nil, setChangeDelegate: changeDelegate, setSectionName: name)
            self.addSubview(textfield)
//            print("cell frame:\(self.frame)")
            let leading = NSLayoutConstraint(item: textfield, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: textfield, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: self.frame.size.height * 0.3)
            let bottom = NSLayoutConstraint(item: textfield, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -(self.frame.size.height * 0.3))
            let trailing = NSLayoutConstraint(item: textfield, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -5)
            NSLayoutConstraint.activate([leading,top,bottom,trailing])
        }
        textfield.whichNum = whichNum
        if cancelBtn == nil{
            cancelBtn = UIButton()
            cancelBtn.setImage(UIImage(named: "error"), for: .normal)
            self.addSubview(cancelBtn)
            cancelBtn.addTarget(self, action: #selector(deleteAction(sender:)), for: .touchUpInside)
            cancelBtn.translatesAutoresizingMaskIntoConstraints = false
            let trailing = NSLayoutConstraint(item: cancelBtn, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
            let top = NSLayoutConstraint(item: cancelBtn, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: self.frame.size.height * 0.25)
            let width = NSLayoutConstraint(item: cancelBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 30)
            let height = NSLayoutConstraint(item: cancelBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
            NSLayoutConstraint.activate([trailing,top,width,height])
        }
        self.layer.contents = 10
        self.layer.masksToBounds = true
        self.layoutIfNeeded()
    }
    @objc func deleteAction(sender:UIButton){
        let dic:NSDictionary = ["sectionName":sectionName,"textfield":textfield]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "deleteItem"), object: dic)
    }
}
