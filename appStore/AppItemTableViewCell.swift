//
//  AppItemTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 15/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit
protocol AppItemTableViewCellDelegate {
    func didSelectRightButton(cell:AppItemTableViewCell)
}
class AppItemTableViewCell: UITableViewCell {
    var delegate:AppItemTableViewCellDelegate?
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageItemView: UIImageView!
    @IBOutlet weak var rightButton: UIButton!
    @IBAction func rightButtonAction(_ sender: Any) {
        self.delegate?.didSelectRightButton(cell: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageItemView.layer.masksToBounds = true
        self.rightButton.setBackgroundImage(UIImage(color:UIColor(white: 0.9, alpha: 1)), for: .normal)
        self.rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        self.rightButton.layer.masksToBounds = true
        self.imageItemView.layer.borderWidth = 1 / UIScreen.main.scale
        self.imageItemView.layer.borderColor = UIColor.lightGray.cgColor
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageItemView.layer.cornerRadius = self.imageItemView.frame.size.width * 0.19
        self.rightButton.layer.cornerRadius = self.rightButton.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
