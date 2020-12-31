//
//  FormDetailTableView.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/31.
//

import UIKit

class FormDetailTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(FormDetailTableViewCell.self, forCellReuseIdentifier: "FormDetailTableViewCell")
        self.backgroundColor = .white
        self.delegate = FormDetailViewModel.sharedInstance
        self.dataSource = FormDetailViewModel.sharedInstance
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
