//
//  SerialOperationQueue.swift
//  appStore
//
//  Created by Peter on 2018. 3. 19..
//  Copyright © 2018년 WEJOApps. All rights reserved.
//

import UIKit

class SerialOperationQueue: OperationQueue {
    override init() {
        super.init()
        maxConcurrentOperationCount = 1
    }
}
