//
//  GalleryViewController.swift
//  appStore
//
//  Created by Peter on 2018. 3. 19..
//  Copyright © 2018년 WEJOApps. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    var items:[UIImage] = []{
        didSet{
            self.collectionView?.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func doneButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func panGRAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.showsHorizontalScrollIndicator = false
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let leftMargin:CGFloat = 50
        if let layout = self.collectionView.collectionViewLayout as? PagingFlowLayout {
            layout.pagingLeftMargin = leftMargin
            layout.sectionInset = UIEdgeInsets(top: 0, left: leftMargin, bottom: 0, right: leftMargin)
            var width = self.collectionView.frame.width - leftMargin * 2
            let height = min(width / 392 * 696, self.collectionView.frame.height)
            width = height / 696 * 392
            layout.itemSize = CGSize(width: width, height: height)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ScreenshotCollectionViewCell
        cell.imageView.image = self.items[indexPath.row]
        return cell
    }
}
