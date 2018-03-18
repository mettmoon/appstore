//
//  AppDetailViewController.swift
//  appStore
//
//  Created by Peter Moon on 15/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

class AppDetailViewController: UIViewController {
    var appListInfo:AppListInfo?
    var appDetailInfo:[String : Any]?
    var appIconImage:UIImage?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.largeTitleDisplayMode = .never
        if let id = appListInfo?.id.attributes?["im:id"] {
            self.loadData(id:id)
        }
    }
    func loadAppImage(){
        guard let urlString = self.appDetailInfo?["artworkUrl512"] as? String , let url = URL(string:urlString) else{return}
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard let data = data else{return}
            if let image = UIImage(data:data) {
                DispatchQueue.main.async {
                    self.appIconImage = image
                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                }
            }
        }.resume()
    }
    func loadData(id:String){
        let urlString = "https://itunes.apple.com/lookup?id=\(id)&country=kr"
        guard let url = URL(string:urlString) else{return}
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            guard let data = data else{return}
            guard let root = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] else{return}
            guard let result = (root?["results"] as? [[String :Any]])?.first else{return}
            DispatchQueue.main.async {
                self.appDetailInfo = result
                self.tableView.reloadData()
                self.loadAppImage()
            }
        }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AppDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func reuseCell(for indexPath:IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return self.tableView.dequeueReusableCell(withIdentifier: "Top", for: indexPath)
        }else if indexPath.row == 1{
            return self.tableView.dequeueReusableCell(withIdentifier: "Rating", for: indexPath)
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.reuseCell(for: indexPath)
        if let cell = cell as? AppDetailTopTableViewCell {
            if cell.appImageView.image == nil {
                if let detail = self.appDetailInfo {
                    cell.appImageView.image = self.appIconImage
                    cell.appActionButton.setTitle(detail["formattedPrice"] as? String, for: .normal)
                    cell.appTitleLabel.text = detail["trackName"] as? String
                }else if let preview = self.appListInfo {
                    cell.appImageView.image = self.appIconImage
                    cell.appActionButton.setTitle(preview.price.text, for: .normal)
                    cell.appTitleLabel.text = preview.title.text
                }
            }
        }else if let cell = cell as? AppDetailRatingTableViewCell, let detail = self.appDetailInfo {
            if let rating = detail["averageUserRatingForCurrentVersion"] as? Double {
                cell.starRatingLabel.text = "\(rating)"
                cell.starRating = rating
            }
            cell.centerRatingTitleLabel.text = nil
            cell.centerRatingValueLabel.text = nil
            cell.rightRatingTitleLabel.text = "Age"
            cell.rightRatingValueLabel.text = detail["trackContentRating"] as? String
            if let value = detail["userRatingCount"] as? Int {
                cell.starRatingDetailLabel.text = value.roundedWithAbbreviations
            }
            
        }
        
        return cell
    }
    
}

extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)만"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)천"
        }
        else {
            return "\(Int(number))"
        }
    }
}
