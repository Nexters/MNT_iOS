//
//  ViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

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
    
    let button = UIButton(title: "Goto", titleColor: .black)
    let textfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "마 적어바라"
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        requestMe()
    }

    fileprivate func setupLayout() {
        let stackView = view.stack(profileImageView,
                   nicknameLabel,
                   textfield,
                   button,
            distribution: .fillEqually)
            
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 200)
        
        let tapGest = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGest)
        
        tapGest.rx.event.bind { (recognizer) in
            self.view.endEditing(true)
        }.disposed(by: rx.disposeBag)
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

