//
//  AppDetailTopTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 15/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit
protocol AppDetailTopTableViewCellDelegate: class {
    func appDetailTopTableViewCellDidAction(cell:AppDetailTopTableViewCell)
    func appDetailTopTableViewCellDidSubAction(cell:AppDetailTopTableViewCell)
}
class AppDetailTopTableViewCell: UITableViewCell {

    weak var delegate:AppDetailTopTableViewCellDelegate?
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appSubTitleLabel: UILabel!
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var appActionButton: UIButton!
    @IBOutlet weak var appSubActionButton: UIButton!
    
    @IBAction func appAction(_ sender: Any) {
        self.delegate?.appDetailTopTableViewCellDidAction(cell: self)
    }
    @IBAction func appSubAction(_ sender: Any) {
        self.delegate?.appDetailTopTableViewCellDidSubAction(cell: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.appActionButton.setBackgroundImage(UIImage(color:self.appActionButton.tintColor), for: .normal)
        self.appActionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        self.appActionButton.setTitleColor(UIColor.white, for: .normal)
        self.appActionButton.layer.masksToBounds = true
        
        self.appSubActionButton.layer.masksToBounds = true
        self.appSubActionButton.setBackgroundImage(UIImage(color:self.appSubActionButton.tintColor), for: .normal)
        self.appActionButton.layer.cornerRadius = self.appActionButton.frame.size.height / 2
        self.appSubActionButton.layer.cornerRadius = self.appActionButton.frame.size.height / 2
        
        self.appImageView.layer.appleIconization()
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
