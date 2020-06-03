//
//  LoginController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/11.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import KakaoOpenSDK
import AuthenticationServices

class LoginController: ViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
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
    
    @available(iOS 13.0, *)
    lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let btn = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        btn.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    @available(iOS 13.0, *)
    @objc fileprivate func appleLogin() {
        let appleIdRequest = ASAuthorizationAppleIDProvider().createRequest()
        appleIdRequest.requestedScopes = [.email, .fullName]

        let controller = ASAuthorizationController(authorizationRequests: [appleIdRequest])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    override func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(logoImage)
        view.addSubview(loginButton)
        if #available(iOS 13.0, *) {
            view.addSubview(appleLoginButton)
        } else {
            // Fallback on earlier versions
        }
        
        logoImage.anchor(
            .top(view.topAnchor, constant: height * 0.217),
            .leading(view.leadingAnchor, constant: (width - (height * 0.273)) * 3 / 5)
        )
        loginButton.anchor(.top(logoImage.bottomAnchor, constant: height * 0.265))
        logoImage.constrainWidth(height * 0.273)
        logoImage.constrainHeight(height * 0.298)
        loginButton.centerXToSuperview()
        if #available(iOS 13.0, *) {
            appleLoginButton.anchor(.top(logoImage.bottomAnchor, constant: height * 0.05))
            appleLoginButton.centerXToSuperview()
        } else {
            // Fallback on earlier versions
        }
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
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            UserDefaults.standard.setStringValue(value: "Apple", key: .socialLogin)
            UserDefaults.standard.setStringValue(value: credential.user, key: .appleUserId)
            UserDefaults.standard.setStringValue(value: credential.fullName?.givenName ?? credential.fullName?.familyName ?? "프루또",
                                                 key: .appleUserName)
            
            APISource.shared.getRoomCheck(userId: credential.user) { (roomCheck) in
                if (roomCheck != nil) {
                    UserDefaults.standard.setObject(object: roomCheck![0].user, key: .user)
                    UserDefaults.standard.setObject(object: roomCheck![0].room, key: .room)
                    
                    if (roomCheck![0].userFruttoId != nil) {
                        UserDefaults.standard.setObject(object: roomCheck![0].manitto, key: .manitto)
                        UserDefaults.standard.setIntValue(value: roomCheck![0].userFruttoId!, key: .userFruttoId)
                        self.viewModel?.presentTabbarAction()
                    } else {
                        self.viewModel?.presentReadyAction()
                    }
                } else {
                    self.viewModel?.presentAgreeAction()
                }
            }
        }
    }
}

extension LoginController: ViewModelBindableType {
    func bindViewModel(viewModel: LoginViewModel) {
        
    }
}
