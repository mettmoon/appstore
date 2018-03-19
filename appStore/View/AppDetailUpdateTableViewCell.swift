//
//  AppDetailUpdateTableViewCell.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

protocol AppDetailUpdateTableViewCellDelegate {
    var isUpdateDescriptionOpen:Bool {get set}
    func appDetailUpdateTableViewCellDidMoreButtonAction(cell:AppDetailUpdateTableViewCell)
}

class AppDetailUpdateTableViewCell: UITableViewCell {
    var delegate:AppDetailUpdateTableViewCellDelegate?
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBAction func moreButtonAction(_ sender: Any) {
        self.delegate?.appDetailUpdateTableViewCellDidMoreButtonAction(cell: self)
    }
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
extension AppDetailViewController: AppDetailUpdateTableViewCellDelegate {
    func appDetailUpdateTableViewCellDidMoreButtonAction(cell: AppDetailUpdateTableViewCell) {
        self.isUpdateDescriptionOpen = true
        let indexPath = IndexPath(row: 0, section: 4)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
