//
//  AppDetailInformationTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit
class AppDetailInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var topLineHeightLC: NSLayoutConstraint!
    @IBOutlet weak var topLineView: UIImageView!
    @IBOutlet weak var expandImageViewWidthLC: NSLayoutConstraint?
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemValueLabel: UILabel!
    @IBOutlet weak var expandImageView: UIImageView?
    var isExpandArrowHidden:Bool = false{
        didSet{
            self.expandImageView?.isHidden = isExpandArrowHidden
            self.expandImageViewWidthLC?.constant = isExpandArrowHidden ? 0 : 16
            self.layoutIfNeeded()
        }
    }
    override func awakeFromNib() {
        self.expandImageView?.isHidden = isExpandArrowHidden
        
        super.awakeFromNib()
        self.itemTitleLabel.text = nil
        self.itemValueLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
