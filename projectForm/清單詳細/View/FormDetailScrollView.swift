//
//  FormDetailScrollView.swift
//  projectForm
//
//  Created by 林信沂 on 2020/12/31.
//

import UIKit

class FormDetailScrollView: UIScrollView {

    func setUp(mainView:UIView,rect:CGRect){
        self.frame = rect
        self.contentSize = CGSize(width: rect.size.width * 2, height: rect.size.height)
        self.isScrollEnabled = true
        self.isDirectionalLockEnabled = true
        self.bounces = true
        self.zoomScale = 2
        self.bouncesZoom = true
        self.isPagingEnabled = true
        self.alwaysBounceHorizontal = true
        self.showsVerticalScrollIndicator = false
//        self.contentOffset = CGPoint(
//            x: mainView.frame.width * 0.5, y: mainView.frame.height * 0.5)
        mainView.addSubview(self)
    }
}
