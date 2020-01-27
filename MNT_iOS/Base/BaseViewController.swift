//
//  BaseViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/27.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGest = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGest)
        
        tapGest.rx.event.bind { (recognizer) in
            self.view.endEditing(true)
        }.disposed(by: rx.disposeBag)
    }
    
    fileprivate func setupLayout() {}
}
