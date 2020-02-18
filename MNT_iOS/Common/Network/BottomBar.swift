//
//  BottomBar.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class BottomBar {
    static let shared = BottomBar()
    private init() {}
    
    func hideBottomBar() {
        NotificationCenter.default.post(name: Notification.Name("ScrollAction"),
                                        object: self,
                                        userInfo: ["TabBarAction":"HIDE"])
    }
    
    func showBottomBar() {
        NotificationCenter.default.post(name: Notification.Name("ScrollAction"),
                                        object: self,
                                        userInfo: ["TabBarAction":"SHOW"])
    }
}
