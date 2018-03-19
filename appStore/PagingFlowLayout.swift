//
//  PagingFlowLayout.swift
//  appStore
//
//  Created by Peter Moon on 19/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

class PagingFlowLayout: UICollectionViewFlowLayout {
    var pagingLeftMargin:CGFloat = 20//페이징시 좌측 여백(살짝보이기)
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let contentOffset = collectionView?.contentOffset else {return proposedContentOffset}
        var index = Int(floor(contentOffset.x / (self.itemSize.width + self.minimumLineSpacing)))
        if velocity.x > 0 {//우로 이동중
            index += 1
        }
        let targetX = CGFloat(index) * (self.itemSize.width + self.minimumLineSpacing) + self.sectionInset.left - pagingLeftMargin
        return CGPoint(x: targetX, y: proposedContentOffset.y)
    }
}

