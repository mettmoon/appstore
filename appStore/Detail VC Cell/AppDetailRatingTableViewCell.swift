//
//  AppDetailRatingTableViewCell.swift
//  appStore
//
//  Created by Peter on 2018. 3. 18..
//  Copyright © 2018년 WEJOApps. All rights reserved.
//

import UIKit

class AppDetailRatingTableViewCell: UITableViewCell {
    @IBOutlet weak var starRatingLC: NSLayoutConstraint!
    @IBOutlet weak var starRatingLabel: UILabel!
    @IBOutlet weak var starRatingDetailLabel: UILabel!
    @IBOutlet weak var centerRatingValueLabel: UILabel!
    @IBOutlet weak var rightRatingValueLabel: UILabel!
    @IBOutlet weak var centerRatingTitleLabel: UILabel!
    @IBOutlet weak var rightRatingTitleLabel: UILabel!
    @IBOutlet weak var starRatingGroupView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var starRating:Double = 5 {
        didSet{
            self.starRatingLabel.text = "\(starRating)"
            self.starRatingLC.constant =  self.starRatingGroupView.frame.width - CGFloat(starRating) * (self.starRatingGroupView.frame.width / 5)
            self.starRatingGroupView.layoutIfNeeded()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
