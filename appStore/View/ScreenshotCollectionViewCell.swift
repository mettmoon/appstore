//
//  ScreenshotCollectionViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.borderWidth = 1 / UIScreen.main.scale
        self.imageView.layer.borderColor = UIColor.lightGray.cgColor
        self.imageView.layer.cornerRadius = self.frame.size.width * 0.05

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
