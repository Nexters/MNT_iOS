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
    
    let textField = UITextField(placeholder: "이름을 입력해주세요.")
    
    lazy var nameStack : UIStackView = {
        let sv: UIStackView?
        if UserDefaults.standard.getStringValue(key: .socialLogin) == "Kakao" {
            sv = UIStackView(arrangedSubviews: [
                nameSubLabel, nameLabel
            ])
            sv!.axis = .vertical
            sv!.spacing = 9
        } else {
            sv = UIStackView(arrangedSubviews: [
                nameSubLabel, textField
            ])
            sv!.axis = .vertical
            sv!.spacing = 9
        }
       return sv!
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activateTapGesture()
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
        textField.constrainWidth(width * 0.84)
        textField.constrainHeight(25.5)
    }
    
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(1.0)
        
        textField.clearButtonMode = .always
        
        border.borderColor = UIColor.moreText.cgColor
        border.frame = CGRect(x: 0,
                              y: textField.frame.size.height - width,
                              width:  textField.frame.size.width,
                              height: textField.frame.size.height)
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
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
            self.title = "반가워요!"
            self.viewModel?.id = UserDefaults.standard.getStringValue(key: .appleUserId)
        }
    }
}

extension ConfirmViewController: ViewModelBindableType {
    func bindViewModel(viewModel: ConfirmViewModel) {
        button.rx.action = viewModel.presentMainAction()
        
        textField.rx.text.orEmpty
            .bind(to: viewModel.nameTextRelay)
            .disposed(by: rx.disposeBag)
    }
}
