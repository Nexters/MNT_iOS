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
    private let KakaoLoginButton: PrimaryButton = {
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
        appleIdRequest.requestedScopes = [.fullName]

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
        view.addSubview(KakaoLoginButton)
        if #available(iOS 13.0, *) {
            view.addSubview(appleLoginButton)
        } else {
            // Fallback on earlier versions
        }
        
        logoImage.anchor(
            .top(view.topAnchor, constant: height * 0.217),
            .leading(view.leadingAnchor, constant: (width - (height * 0.273)) * 3 / 5)
        )
        KakaoLoginButton.anchor(.top(logoImage.bottomAnchor, constant: height * 0.2))
        logoImage.constrainWidth(height * 0.273)
        logoImage.constrainHeight(height * 0.298)
        KakaoLoginButton.centerXToSuperview()
        
        if #available(iOS 13.0, *) {
            appleLoginButton.anchor(.top(KakaoLoginButton.bottomAnchor, constant: 10))
            appleLoginButton.centerXToSuperview()
            appleLoginButton.constrainWidth(width * 0.893)
            appleLoginButton.constrainHeight(width * 0.13)
            KakaoLoginButton.constrainHeight(width * 0.13)
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
            
            APISource.shared.getRoomCheck(userId: credential.user) { (roomCheck) in
                let roomNum: Int = roomCheck?.count ?? 0
                
                if roomNum == 0 { // 참가한 방이 하나도 없음
                    self.viewModel?.presentAgreeAction()
                } else {
                    let index = roomNum - 1 // 마지막으로 참가한 방의 인덱스
                    
                    if roomCheck![index].room.isDone == 1 { // 방이 종료됨
                        self.viewModel?.presentAgreeAction()
                    } else {
                        UserDefaults.standard.setObject(object: roomCheck![index].user, key: .user)
                        UserDefaults.standard.setObject(object: roomCheck![index].room, key: .room)
                        
                        if roomCheck![index].room.isStart == 1 { // 방이 시작됨
                            UserDefaults.standard.setObject(object: roomCheck![index].manitto, key: .manitto)
                            UserDefaults.standard.setIntValue(value: roomCheck![index].userFruttoId!, key: .userFruttoId)
                            UserDefaults.standard.setIntValue(value: 1, key: .isEntered)
                            self.viewModel?.presentTabbarAction()
                        } else { // 방이 시작되지 않음
                            self.viewModel?.presentReadyAction()
                        }
                    }
                }
            }
        }
    }
}

extension LoginController: ViewModelBindableType {
    func bindViewModel(viewModel: LoginViewModel) {
        
    }
}
