//
//  TitleView.swift
//  appStore
//
//  Created by Peter on 2018. 3. 19..
//  Copyright © 2018년 WEJOApps. All rights reserved.
//

import UIKit

class TitleView: UIView {
    var baseView:UIView
    var imageView:UIImageView
    var borderView:UIView
    override init(frame: CGRect) {
        self.baseView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width - 5, height: frame.height - 5))
        self.borderView = UIView(frame:self.baseView.bounds)
        self.imageView = UIImageView(frame: self.baseView.bounds)
        super.init(frame: frame)
        self.baseView.center = self.center
        self.addSubview(self.baseView)
        self.baseView.addSubview(self.borderView)
        self.borderView.addSubview(imageView)
        
        self.baseView.backgroundColor = UIColor.clear
        self.baseView.layer.shadowColor = UIColor.gray.cgColor
        self.baseView.layer.shadowRadius = 5
        self.baseView.layer.shadowOpacity = 0.6
        self.baseView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.borderView.layer.appleIconization()
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
