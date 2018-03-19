//
//  AppDetailInformationLinkTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

class AppDetailInformationLinkTableViewCell: UITableViewCell {

    @IBOutlet weak var topLineHeightLC: NSLayoutConstraint!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var topLineView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.itemTitleLabel.text = nil
        self.itemImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
