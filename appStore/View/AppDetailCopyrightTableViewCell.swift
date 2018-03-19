//
//  AppDetailCopyrightTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

class AppDetailCopyrightTableViewCell: UITableViewCell {

    @IBOutlet weak var itemValueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.itemValueLabel.text = nil
    }

}
