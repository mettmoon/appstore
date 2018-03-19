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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.appImageView.image = nil
        self.appSubTitleLabel.text = nil
        self.appTitleLabel.text = nil
        self.appActionButton.setTitle(nil, for: .normal)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.appActionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.appSubActionButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.appActionButton.setBackgroundImage(UIImage(color:self.appActionButton.tintColor), for: .normal)
        self.appActionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        self.appActionButton.setTitleColor(UIColor.white, for: .normal)
        self.appActionButton.layer.masksToBounds = true
        
        self.appSubActionButton.layer.masksToBounds = true
        self.appSubActionButton.setBackgroundImage(UIImage(color:self.appSubActionButton.tintColor), for: .normal)
        self.appSubActionButton.tintColor = UIColor.white
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
extension AppDetailViewController : AppDetailTopTableViewCellDelegate {
    func appDetailTopTableViewCellDidAction(cell: AppDetailTopTableViewCell) {
        if let urlString = self.appDetailInfo?["trackViewUrl"] as? String, let url = URL(string:urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (finish) in
                print("finished")
            })
        }
    }
    func appDetailTopTableViewCellDidSubAction(cell: AppDetailTopTableViewCell) {
        if let urlString = self.appDetailInfo?["trackViewUrl"] as? String, let url = URL(string:urlString) {
            let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "공유", style: .default, handler: { (action) in
                self.shareAction(url)
            }))
            ac.addAction(UIAlertAction(title: "앱스토어로 가기", style: .default, handler: { (action) in
                UIApplication.shared.open(url, options: [:], completionHandler: { (finish) in
                    print("finished")
                })
            }))
            ac.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
    func shareAction(_ url:URL){
        let avc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.present(avc, animated: true, completion: nil)
    }
}
