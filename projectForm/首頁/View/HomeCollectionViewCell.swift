//
//  HomeCollectionViewCell.swift
//  表單管理
//
//  Created by 林信沂 on 2020/12/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    var formNameLabel:UILabel!
    var imgV:UIImageView!
    var jumpFormPageBtn:UIButton!
    var googleModel:GoogleFormModel!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp(text:String,model:GoogleFormModel){
        googleModel = model
        if imgV == nil{
            imgV = UIImageView()
            self.addSubview(imgV)
            imgV.image = UIImage(named: "form")
            imgV.contentMode = .scaleAspectFit
            imgV.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: imgV, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
            let trailing = NSLayoutConstraint(item: imgV, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
            let top = NSLayoutConstraint(item: imgV, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
            let height = NSLayoutConstraint(item: imgV, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.6)
            self.addConstraints([leading,trailing,top,height])
        }
        if formNameLabel == nil{
            formNameLabel = UILabel()
            formNameLabel.textColor = .black
            formNameLabel.textAlignment = .center
            formNameLabel.numberOfLines = 0
            formNameLabel.sizeToFit()
            formNameLabel.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(formNameLabel)
            formNameLabel.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: formNameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
            let trailing = NSLayoutConstraint(item: formNameLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
            let top = NSLayoutConstraint(item: formNameLabel, attribute: .top, relatedBy: .equal, toItem: imgV, attribute: .bottom, multiplier: 1.0, constant: 0)
            let hieght = NSLayoutConstraint(item: formNameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: self.frame.size.height * 0.3)
//            let bottom = NSLayoutConstraint(item: formNameLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
            self.addConstraints([leading,trailing,top,hieght])
        }
        formNameLabel.text = text
        if jumpFormPageBtn == nil{
            jumpFormPageBtn = UIButton()
            jumpFormPageBtn.setTitle("填寫表單", for: .normal)
            jumpFormPageBtn.backgroundColor = .black
            jumpFormPageBtn.setTitleColor(.white, for: .normal)
            jumpFormPageBtn.addTarget(self, action: #selector(btnAction(sender:)), for: .touchUpInside)
            self.addSubview(jumpFormPageBtn)
            jumpFormPageBtn.translatesAutoresizingMaskIntoConstraints = false
            let leading = NSLayoutConstraint(item: jumpFormPageBtn, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
            let trailing = NSLayoutConstraint(item: jumpFormPageBtn, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
            let top = NSLayoutConstraint(item: jumpFormPageBtn, attribute: .top, relatedBy: .equal, toItem: formNameLabel, attribute: .bottom, multiplier: 1.0, constant: 0)
            let bottom = NSLayoutConstraint(item: jumpFormPageBtn, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
            self.addConstraints([leading,trailing,top,bottom])
        }
    }
    @objc func btnAction(sender:UIButton){
        ViewModel.sharedInstance.jumpFormAction(mode: googleModel)
    }
}
