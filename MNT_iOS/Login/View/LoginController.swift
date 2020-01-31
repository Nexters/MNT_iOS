//
//  LoginController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/11.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import KakaoOpenSDK

class LoginController: ViewController {
    
    private let loginButton: KOLoginButton = {
        let button = KOLoginButton()
        button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var viewModel: LoginViewModel?
    
    @objc fileprivate func touchUpLoginButton(_ sender: UIButton) {
        guard let session = KOSession.shared() else {
            return
        }
        
        if session.isOpen() {
            session.close()
        }
        
        session.open { (error) in
            if error != nil || !session.isOpen() { return }
            KOSessionTask.userMeTask(completion: { (error, user) in
                guard let user = user,
                    let email = user.account?.email,
                    let nickname = user.nickname else { return }
                
                let mainVC = MainViewController()
                mainVC.nicknameLabel.text = nickname
                mainVC.profileImageView.kf.setImage(with: user.profileImageURL)
                mainVC.modalPresentationStyle = .fullScreen
                
                self.present(mainVC, animated: false, completion: nil)
            })
        }
    }
    
    override func setupLayout() {
        view.addSubview(loginButton)
        
        var bottomMargin: CGFloat = -30
        if #available(iOS 11.0, *) {
            bottomMargin = bottomMargin - 30
        }
        
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomMargin).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension LoginController: ViewModelBindableType {
    func bindViewModel(viewModel: LoginViewModel) {
        
    }
}
