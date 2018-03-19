//
//  AppDetailDescriptionTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit
protocol AppDetailDescriptionTableViewCellDelegate{
    func appDetailDescriptionTableViewCellmoreButtonAction(cell:AppDetailDescriptionTableViewCell)
}
class AppDetailDescriptionTableViewCell: UITableViewCell {
    var delegate:AppDetailDescriptionTableViewCellDelegate?
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBAction func moreButtonAction(_ sender: Any) {
        self.delegate?.appDetailDescriptionTableViewCellmoreButtonAction(cell: self)
    }
    @IBOutlet weak var moreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension AppDetailViewController: AppDetailDescriptionTableViewCellDelegate {
    func appDetailDescriptionTableViewCellmoreButtonAction(cell: AppDetailDescriptionTableViewCell) {
        self.isDescriptionOpen = true
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .automatic)
    }
}
