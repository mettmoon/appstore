//
//  AppDetailScreenshotListTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

class AppDetailScreenshotListTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.subTitleLabel.text = nil
    }


}
