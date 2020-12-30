//
//  HomeCollectionView.swift
//  表單管理
//
//  Created by 林信沂 on 2020/12/22.
//

import UIKit

class HomeCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayOut(view:UIView){
        self.setBackgroudColor(color: .clear)
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 10)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([leading,trailing,top,bottom])
    }
    func setBackgroudColor(color:UIColor){
        self.backgroundColor = color
    }
    
}
