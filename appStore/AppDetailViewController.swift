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
    var screenshotImages:[UIImage]?
    var screenshotFlowLayout:PagingFlowLayout?
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
        url.toImage { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.appIconImage = image
                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                }
            }
        }
    }
    //스크린샷이미지들을 로드하고 완료하면 UI업데이트를 합니다.
    func loadScreenshotImage(){
        guard let screenshotUrlStrings = self.appDetailInfo?["screenshotUrls"] as? [String] else{return}
        DispatchQueue.global().async {
            var loadedCount = 0
            var images:[UIImage] = []
            let semaphore = DispatchSemaphore(value: 0)
            for urlString in screenshotUrlStrings {
                guard let url = URL(string:urlString) else{ return }
                url.toImage({ (image) in
                    if let image = image {
                        images.append(image)
                    }
                    loadedCount += 1
                    if screenshotUrlStrings.count == loadedCount {
                        semaphore.signal()
                    }
                })
            }
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            DispatchQueue.main.async {
                self.screenshotImages = images
                self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .none)

            }
        }

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
                self.loadScreenshotImage()
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
        }else if indexPath.row == 2{
            return self.tableView.dequeueReusableCell(withIdentifier: "Screenshot List", for: indexPath)
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.reuseCell(for: indexPath)
        if let cell = cell as? AppDetailTopTableViewCell {
            cell.delegate = self
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
            
        }else if let cell = cell as? AppDetailScreenshotListTableViewCell {
            cell.subTitleLabel.text = "iPhone"
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            if let flowlayout = self.screenshotFlowLayout {
                cell.collectionView.collectionViewLayout = flowlayout

            }else if let layout = cell.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                self.screenshotFlowLayout = PagingFlowLayout()
                self.screenshotFlowLayout?.itemSize = layout.itemSize
                self.screenshotFlowLayout?.minimumLineSpacing = layout.minimumLineSpacing
                self.screenshotFlowLayout?.minimumInteritemSpacing = layout.minimumInteritemSpacing
                self.screenshotFlowLayout?.sectionInset = layout.sectionInset
                self.screenshotFlowLayout?.scrollDirection = layout.scrollDirection
            }
            
        }
        
        return cell
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
extension AppDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.screenshotImages == nil ? 0 : 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = self.screenshotImages else{ return 0}
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Screenshot", for: indexPath) as! ScreenshotCollectionViewCell
        cell.imageView.image = self.screenshotImages?[indexPath.row]
        return cell
    }
}
class PagingFlowLayout: UICollectionViewFlowLayout {
    var pagingLeftMargin:CGFloat = 20//페이징시 좌측 여백(살짝보이기)
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let contentOffset = collectionView?.contentOffset else {return proposedContentOffset}
        var index = Int(floor(contentOffset.x / (self.itemSize.width + self.minimumLineSpacing)))
        if contentOffset.x < proposedContentOffset.x {
            //우로 이동중
            index += 1
        }
        let targetX = CGFloat(index) * (self.itemSize.width + self.minimumLineSpacing) + self.sectionInset.left - pagingLeftMargin
        return CGPoint(x: targetX, y: proposedContentOffset.y)
    }
}
