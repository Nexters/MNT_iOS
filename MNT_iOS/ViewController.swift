//
//  ViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let emailLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()
    let nicknameLabel: UILabel = {
        let lb = UILabel()
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    fileprivate func setupLayout() {
        view.addSubview(emailLabel)
        view.addSubview(nicknameLabel)
        
        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nicknameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            nicknameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

