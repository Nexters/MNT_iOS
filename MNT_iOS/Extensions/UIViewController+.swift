//
//  UIViewController+.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/25.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

extension UIViewController {
    func setNaivgationItemsAsDefault() {
        let navigationItem = self.navigationItem
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.tintColor = .defaultText
            let inset = UIEdgeInsets(top: -16, left: -16, bottom: 0, right: 0)
            navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "arrowLeft").withAlignmentRectInsets(inset)
        }
    }
}
