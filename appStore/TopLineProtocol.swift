//
//  TopLineProtocol.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

protocol TopLineProtocol {
    var isTopLineHidden:Bool {get set}
    var topLineColor:UIColor? {get set}
    var topLineHeight:CGFloat {get set}
}

extension AppDetailInformationLinkTableViewCell : TopLineProtocol {
    var isTopLineHidden: Bool {
        get{
            return self.topLineView.isHidden
        }
        set{
            self.topLineView.isHidden = newValue
        }
    }
    var topLineColor: UIColor? {
        get{
            return self.topLineView.backgroundColor
        }
        set{
            self.topLineView.backgroundColor = newValue
        }
    }
    var topLineHeight: CGFloat {
        get{
            return self.topLineHeightLC.constant
        }
        set{
            self.topLineHeightLC.constant = newValue
        }
    }
}
extension AppDetailInformationTableViewCell: TopLineProtocol {
    var isTopLineHidden: Bool {
        get{
            return self.topLineView.isHidden
        }
        set{
            self.topLineView.isHidden = newValue
        }
    }
    var topLineColor: UIColor? {
        get{
            return self.topLineView.backgroundColor
        }
        set{
            self.topLineView.backgroundColor = newValue
        }
    }
    var topLineHeight: CGFloat {
        get{
            return self.topLineHeightLC.constant
        }
        set{
            self.topLineHeightLC.constant = newValue
        }
    }

}
