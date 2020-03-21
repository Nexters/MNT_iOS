//
//  BaseViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/27.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    lazy var topAnchor: NSLayoutYAxisAnchor = {
        var topAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *) {
            topAnchor = view.safeAreaLayoutGuide.topAnchor
        } else {
            topAnchor = view.topAnchor
        }
        return topAnchor
    }()
    
    lazy var bottomAnchor: NSLayoutYAxisAnchor = {
        var bottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *) {
            bottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            bottomAnchor = view.bottomAnchor
        }
        return bottomAnchor
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationController()
    }
    
    func activateTapGesture() {
        let tapGest = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGest)
        
        tapGest.rx.event.bind { (recognizer) in
            self.view.endEditing(true)
        }.disposed(by: rx.disposeBag)
    }
    
    func setupLayout() {}
    
    func setupNavigationController() {}
    
    func requestAPIs() {}
}
