//
//  ShopButtonView.swift
//  appStore
//
//  Created by Peter on 2018. 3. 19..
//  Copyright © 2018년 WEJOApps. All rights reserved.
//

import UIKit

class ShopButtonView: UIView {
    let appActionButton:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 74, height: 30))
    var title:String? {
        get{
            return self.appActionButton.title(for: .normal)
        }
        set{
            self.appActionButton.setTitle(newValue, for: .normal)
            self.appActionButton.sizeToFit()
            self.appActionButton.frame.size.height = 30
            self.appActionButton.frame.origin.x = self.frame.width - self.appActionButton.frame.width
        }
    }
    func addTarget(target: Any?, action: Selector, for controlEvents: UIControlEvents){
        self.appActionButton.addTarget(target, action: action, for: controlEvents)
    }
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 74, height: 30))
        self.appActionButton.setBackgroundImage(UIImage(color:self.appActionButton.tintColor), for: .normal)
        self.appActionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        self.appActionButton.setTitleColor(UIColor.white, for: .normal)
        self.appActionButton.layer.masksToBounds = true
        self.appActionButton.layer.cornerRadius = self.appActionButton.frame.size.height / 2
        self.appActionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.addSubview(self.appActionButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
