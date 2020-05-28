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
    
    var viewModel: LoginViewModel?
    var confirmViewModel: ConfirmViewModel?
    let logoImage = UIImageView(image: #imageLiteral(resourceName: "frutto1"))
    private let loginButton: PrimaryButton = {
        let button = PrimaryButton("카카오 ID로 로그인")
        button.addTarget(self,
                         action: #selector(touchUpLoginButton(_:)),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(logoImage)
        view.addSubview(loginButton)
        
        logoImage.anchor(
            .top(view.topAnchor, constant: height * 0.217),
            .leading(view.leadingAnchor, constant: (width - (height * 0.273)) * 3 / 5)
        )
        loginButton.anchor(.top(logoImage.bottomAnchor, constant: height * 0.265))
        logoImage.constrainWidth(height * 0.273)
        logoImage.constrainHeight(height * 0.298)
        loginButton.centerXToSuperview()
    }
    
    @objc fileprivate func touchUpLoginButton(_ sender: UIButton) {
        guard let session = KOSession.shared() else {
            return
        }
        
        if session.isOpen() {
            session.close()
        }
        
        session.open { (error) in
            if error != nil || !session.isOpen() { return }
        }
    }
}

extension LoginController: ViewModelBindableType {
    func bindViewModel(viewModel: LoginViewModel) {
        
    }
}
