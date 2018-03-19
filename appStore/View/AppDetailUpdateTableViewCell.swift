//
//  AppDetailUpdateTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

class AppDetailUpdateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.itemTitleLabel.text = nil
        self.versionLabel.text = nil
        self.periodLabel.text = nil
        self.descriptionLabel.text = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let image = #imageLiteral(resourceName: "more_bg").resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0))
        self.moreButton.setBackgroundImage(image, for: .normal)
        self.moreButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

