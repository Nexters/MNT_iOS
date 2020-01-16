//
//  ViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    let nicknameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = lb.font.withSize(20)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        lb.adjustsFontSizeToFitWidth = true
        return lb
    }()
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        requestMe()
    }

    fileprivate func setupLayout() {
        view.addSubview(nicknameLabel)
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            nicknameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nicknameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nicknameLabel.heightAnchor.constraint(equalToConstant: 30),
            nicknameLabel.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            profileImageView.bottomAnchor.constraint(equalTo: nicknameLabel.topAnchor, constant: -40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    fileprivate func requestMe() {
        KOSessionTask.userMeTask { [unowned self] (error, me) in
            guard
                let me = me,
                let account = me.account
                else {return}
            
            self.nicknameLabel.text = me.nickname
            guard let profileImageUrl = account.profile?.profileImageURL else {return}
            DispatchQueue.main.async {
                self.profileImageView.kf.setImage(with: profileImageUrl)
            }
        }
    }
}

