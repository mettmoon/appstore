//
//  AppListViewController.swift
//  appStore
//
//  Created by Peter Moon on 15/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit
class AppListViewController: UIViewController {
    var items:[AppListInfo] = []
    var images:[URL: UIImage] = [:]
    @IBOutlet weak var loadIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadIndicatorGroupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: animated)
        }
    }
    func loadData(){
        guard let url = URL(string:Result.endPoint) else{return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{return}
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(Result.self, from: data)
                DispatchQueue.main.async {
                    self.items = result.feed.entry
                    self.tableView.reloadData()
                    UIView.animate(withDuration: 0.35, animations: {
                        self.loadIndicatorGroupView.alpha = 0
                    }, completion: { (finish) in
                        if finish {
                            self.loadIndicatorView.stopAnimating()
                            self.loadIndicatorGroupView.isHidden = true
                        }
                    })
                }
            }catch {
                return
            }
            
            
            }.resume()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.images = [:]
        // Dispose of any resources that can be recreated.
    }
    var downloadQueue = DispatchQueue(label: "download.AppListViewController")
    var inprogressURLs:[URL] = []
    typealias ImageCompletion = ((UIImage) -> Void)
    var standbyCompletions:[URL:[ImageCompletion]] = [:]
    func downloadImage(imageURL:URL, completion:ImageCompletion?){
        self.downloadQueue.async {
            if let image = self.images[imageURL] {
                completion?(image)
                return
            }
            if let completion = completion  {
                if let completions = self.standbyCompletions[imageURL] {
                    var completions = completions
                    completions.append(completion)
                    self.standbyCompletions[imageURL] = completions
                }else{
                    self.standbyCompletions[imageURL] = [completion]
                }
            }
            if self.inprogressURLs.contains(imageURL) {
                //중복요청
                return
            }
            self.inprogressURLs.append(imageURL)
            URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
                self.downloadQueue.async {
                    if let data = data, let image = UIImage(data: data) {
                        if let completions = self.standbyCompletions[imageURL] {
                            self.images[imageURL] = image
                            for completion in completions {
                                completion(image)
                            }
                            self.standbyCompletions[imageURL] = nil
                        }
                    }
                    if let index = self.inprogressURLs.index(of: imageURL) {
                        self.inprogressURLs.remove(at: index)
                    }
                }
            }).resume()
        }
    }

    func item(for indexPath:IndexPath) -> AppListInfo {
        return self.items[indexPath.row]
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail", let cell = sender as? UITableViewCell, let indexPath = self.tableView.indexPath(for: cell), let vc = segue.destination as? AppDetailViewController {
            let info = self.item(for: indexPath)
            vc.appListInfo = info
            if let urlString = info.image.last?.text, let url = URL(string:urlString) {
                if let image = self.images[url] {
                    vc.appIconImage = image
                }
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

extension AppListViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? AppItemTableViewCell {
            cell.subTitleLabel.sizeToFit()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = self.item(for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AppItemTableViewCell
        cell.imageItemView.image = nil
        cell.delegate = self
        cell.titleLabel.text = info.name.text
        cell.subTitleLabel.text = info.summary?.text
        cell.rightButton.setTitle(info.price.text, for: .normal)
        cell.rankLabel.text = "\(indexPath.row + 1)"
        if let urlString = info.image.last?.text, let url = URL(string:urlString) {
            if let image = self.images[url] {
                cell.imageItemView.image = image
            }else{
                self.downloadImage(imageURL: url, completion: { (image) in
                    DispatchQueue.main.async {
                        if tableView.cellForRow(at: indexPath) == cell {
                            cell.imageItemView.image = image
                        }
                    }
                })
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let info = self.item(for: indexPath)
            if let urlString = info.image.last?.text, let url = URL(string:urlString) {
                if self.images[url] == nil {
                    self.downloadImage(imageURL: url, completion: nil)
                }
                
            }

        }
    }
}
extension AppListViewController: AppItemTableViewCellDelegate {
    func didSelectRightButton(cell: AppItemTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else{ return }
        let info = self.item(for: indexPath)
        if let urlString = info.link.attributes?["href"], let url = URL(string:urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (finish) in
                print("finished")
            })
        }
    }
}
