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
    override func prepareForReuse() {
        super.prepareForReuse()
        self.itemValueLabel.text = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
