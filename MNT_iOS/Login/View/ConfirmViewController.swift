//
//  ConfirmViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import AuthenticationServices

class ConfirmViewController: ViewController{
    var viewModel: ConfirmViewModel?
    let profileImage = UIImageView(image: #imageLiteral(resourceName: "profileFace01"))
    var userId: String?
    var userName: String?
    var button = PrimaryButton("푸르또 시작하기🍎")
    let nameSubLabel = UILabel(text: "이름",
                               font: .mediumFont(ofSize: 13),
                               textColor: .subLabelColor,
                               textAlignment: .left,
                               numberOfLines: 0)
    
    let nameLabel = UILabel(text: "",
                            font: .mediumFont(ofSize: 17),
                            textColor: .defaultText,
                            textAlignment: .left,
                            numberOfLines: 0)
    
    lazy var nameStack : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            nameSubLabel, nameLabel
        ])
        sv.axis = .vertical
        sv.spacing = 9
       return sv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        requestMe()
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(profileImage)
        view.addSubview(nameStack)
        view.addSubview(button)
        
        profileImage.anchor(
            .top(view.topAnchor, constant: height * 0.273)
        )
        nameStack.anchor(
            .top(profileImage.bottomAnchor, constant: height * 0.132),
            .leading(view.leadingAnchor, constant: width * 0.096)
        )
        button.anchor(
            .top(profileImage.bottomAnchor, constant: height * 0.408)
        )
        profileImage.centerXToSuperview()
        button.centerXToSuperview()
    }
    
    fileprivate func requestMe() {
        if UserDefaults.standard.getStringValue(key: .socialLogin) == "Kakao" {
            KOSessionTask.userMeTask(completion: { (error, me) in
                if let error = error as NSError? {
                    UIAlertController.showMessage(error.description)
                } else if let me = me as KOUserMe? {
                    self.nameLabel.text = me.nickname
                    self.title = "\(me.nickname as! String)님, 반가워요!"
                    self.viewModel?.id = me.id
                    self.viewModel?.name = me.nickname
                } else {
                    print("has no id")
                }
            })
        } else {
            self.nameLabel.text = UserDefaults.standard.getStringValue(key: .appleUserName)!
            self.title = "\(UserDefaults.standard.getStringValue(key: .appleUserName)!)님, 반가워요!"
            self.viewModel?.id = UserDefaults.standard.getStringValue(key: .appleUserId)
            self.viewModel?.name = UserDefaults.standard.getStringValue(key: .appleUserName)
        }
    }
}

extension ConfirmViewController: ViewModelBindableType {
    func bindViewModel(viewModel: ConfirmViewModel) {
        button.rx.action = viewModel.presentMainAction()
    }
}
