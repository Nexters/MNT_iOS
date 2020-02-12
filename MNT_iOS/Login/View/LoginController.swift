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
    
//    private let loginButton: KOLoginButton = {
//        let button = KOLoginButton()
//        button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private let loginButton: AccentButton = {
        let button = AccentButton("카카오 ID로 로그인")
        button.addTarget(self, action: #selector(touchUpLoginButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logoImage = UIImageView(image: #imageLiteral(resourceName: "logo"))
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
                
//                let mainVC = MainViewController()
//                mainVC.nicknameLabel.text = nickname
//                mainVC.profileImageView.kf.setImage(with: user.profileImageURL)
//                mainVC.modalPresentationStyle = .fullScreen
                
                let confirmVC = ConfirmViewController()
                confirmVC.nicknameLabel.text = nickname
                confirmVC.profileImageView.kf.setImage(with: user.profileImageURL)
                confirmVC.modalPresentationStyle = .fullScreen
                
                self.present(confirmVC, animated: false, completion: nil)
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.isNavigationBarHidden = false
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.stack(view.hstack(UIView().withWidth(width * 0.3),
                               logoImage.withWidth(width * 0.45),
                               UIView().withWidth(width * 0.25)),
                   UIView().withHeight(height * 0.279),
                   view.hstack(UIView().withWidth(width * 0.053),
                               loginButton.withHeight(height * 0.069)
                                          .withWidth(width * 0.893),
                               UIView().withWidth(width * 0.053)))
            .withMargins(.init(top: height * 0.203, left: 0, bottom: height * 0.11, right: 0))
        
    }
}

extension LoginController: ViewModelBindableType {
    func bindViewModel(viewModel: LoginViewModel) {
        
    }
}
