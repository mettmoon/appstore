//
//  AppDetailDescriptionTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit
class AppDetailDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.moreButton.isUserInteractionEnabled = false
        let image = #imageLiteral(resourceName: "more_bg").resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0))
        self.moreButton.setBackgroundImage(image, for: .normal)
        self.moreButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        self.descriptionLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


