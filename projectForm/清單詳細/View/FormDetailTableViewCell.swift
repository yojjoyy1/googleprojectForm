//
//  FormDetailTableViewCell.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/31.
//

import UIKit

class FormDetailTableViewCell: UITableViewCell {

    var numberOder:UILabel!
    var wOderLabel:UILabel!
    var sizeLabel:UILabel!
    var countLabel:UILabel!
    var nameLabel:UILabel!
    var emailLabel:UILabel!
    var remakeTextView:UITextView!
    var phoneLabel:UILabel!
    var addressLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUp(model:FormDetailModel,indexRow:Int){
        self.backgroundColor = .white
        if numberOder == nil{
            numberOder = UILabel()
            numberOder.textColor = .black
            numberOder.textAlignment = .center
            self.addSubview(numberOder)
            numberOder.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: numberOder, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: numberOder, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10)
            let trailing = NSLayoutConstraint(item: numberOder, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: numberOder, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.1)
            self.addConstraints([leading,top,trailing,height])
        }
        numberOder.text = "第\(indexRow+1)單"
        if wOderLabel == nil{
            wOderLabel = UILabel()
            wOderLabel.textColor = .black
            self.addSubview(wOderLabel)
            wOderLabel.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: wOderLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: wOderLabel, attribute: .top, relatedBy: .equal, toItem: numberOder, attribute: .top, multiplier: 1.0, constant: 10)
            let trailing = NSLayoutConstraint(item: wOderLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: wOderLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.1)
            self.addConstraints([leading,top,trailing,height])
        }
        wOderLabel.text = "品項:\(model.wOder!)"
        if sizeLabel == nil{
            sizeLabel = UILabel()
            sizeLabel.textColor = .black
            self.addSubview(sizeLabel)
            sizeLabel.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: sizeLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: sizeLabel, attribute: .top, relatedBy: .equal, toItem: wOderLabel, attribute: .bottom, multiplier: 1.0, constant: 5)
            let trailing = NSLayoutConstraint(item: sizeLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: sizeLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.1)
            self.addConstraints([leading,top,trailing,height])
        }
//        sizeLabel.text = "規格:\(model.size!)"
        sizeLabel.attributedText = getAttr(frontText: "規格:", rangeText: model.size!, allText: "規格:\(model.size!)")
        if countLabel == nil{
            countLabel = UILabel()
            countLabel.textColor = .black
            self.addSubview(countLabel)
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: countLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: countLabel, attribute: .top, relatedBy: .equal, toItem: sizeLabel, attribute: .bottom, multiplier: 1.0, constant: 5)
            let trailing = NSLayoutConstraint(item: countLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: countLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.1)
            self.addConstraints([leading,top,trailing,height])
        }
//        countLabel.text = "數量:\(model.count!)"
        countLabel.attributedText = getAttr(frontText: "數量:", rangeText: model.count!, allText: "數量:\(model.count!)")
        if nameLabel == nil{
            nameLabel = UILabel()
            nameLabel.textColor = .black
            self.addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: countLabel, attribute: .bottom, multiplier: 1.0, constant: 5)
            let trailing = NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.1)
            self.addConstraints([leading,top,trailing,height])
        }
        nameLabel.text = "姓名:\(model.name!)"
        if emailLabel == nil{
            emailLabel = UILabel()
            emailLabel.textColor = .black
            emailLabel.isHidden = model.email!.isEmpty ? true:false
            self.addSubview(emailLabel)
            emailLabel.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: emailLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: emailLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 5)
            let trailing = NSLayoutConstraint(item: emailLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: emailLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.1)
            self.addConstraints([leading,top,trailing,height])
        }
        emailLabel.text = "信箱:\(model.email!)"
        if phoneLabel == nil{
            phoneLabel = UILabel()
            phoneLabel.textColor = .black
            self.addSubview(phoneLabel)
            phoneLabel.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: phoneLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: phoneLabel, attribute: .top, relatedBy: .equal, toItem: emailLabel.isHidden ? nameLabel:emailLabel, attribute: .bottom, multiplier: 1.0, constant: 5)
            let trailing = NSLayoutConstraint(item: phoneLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: phoneLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.1)
            self.addConstraints([leading,top,trailing,height])
        }
        phoneLabel.text = "電話:\(model.phone!)"
        if addressLabel == nil{
            addressLabel = UILabel()
            addressLabel.textColor = .black
            self.addSubview(addressLabel)
            addressLabel.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: addressLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: addressLabel, attribute: .top, relatedBy: .equal, toItem: phoneLabel, attribute: .bottom, multiplier: 1.0, constant: 5)
            let trailing = NSLayoutConstraint(item: addressLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let height = NSLayoutConstraint(item: addressLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.1)
            self.addConstraints([leading,top,trailing,height])
        }
        addressLabel.text = "地址:\(model.address!)"
        if remakeTextView == nil{
            remakeTextView = UITextView()
            remakeTextView.textColor = .black
            remakeTextView.backgroundColor = .white
            remakeTextView.font = UIFont.systemFont(ofSize: 17)
            remakeTextView.isEditable = false
            remakeTextView.isScrollEnabled = true
            self.addSubview(remakeTextView)
            remakeTextView.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: remakeTextView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 10)
            let top = NSLayoutConstraint(item: remakeTextView, attribute: .top, relatedBy: .equal, toItem: addressLabel, attribute: .bottom, multiplier: 1.0, constant: 5)
            let trailing = NSLayoutConstraint(item: remakeTextView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -10)
            let bottom = NSLayoutConstraint(item: remakeTextView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10)
            self.addConstraints([leading,top,trailing,bottom])
        }
        remakeTextView.text = "備註:\(model.remark!)"
    }

    func getAttr(frontText:String,rangeText:String,allText:String) -> NSMutableAttributedString{
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18.0)! ]
        let myString = NSMutableAttributedString(string: allText, attributes: myAttribute )
        let myRange = NSRange(location: frontText.count, length: rangeText.count)
//        print("myRange:\(myRange)")
        let anotherAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.red ]
        myString.addAttributes(anotherAttribute, range: myRange)
        return myString
    }
}
