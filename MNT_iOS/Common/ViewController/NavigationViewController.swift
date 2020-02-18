//
//  NavigationViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/18.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // Do any additional setup after loading the view.
    }
}
