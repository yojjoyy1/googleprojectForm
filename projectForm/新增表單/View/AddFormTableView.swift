//
//  AddFormTableView.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/27.
//

import UIKit

class AddFormTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(AddFormTableViewCell.self, forCellReuseIdentifier: "AddFormTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setAutoLayout(view:UIView){
        self.backgroundColor = .white
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        let lead = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0)
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([lead,trailing,top,bottom])
    }

}
