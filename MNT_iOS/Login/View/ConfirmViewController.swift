//
//  ConfirmViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class ConfirmViewController: ViewController {
    
    var viewModel: ConfirmViewModel?
    let profileImage = UIImageView(image: #imageLiteral(resourceName: "profileFace01"))
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
    
    let idSubLabel = UILabel(text: "카카오 ID",
                               font: .mediumFont(ofSize: 13),
                               textColor: .subLabelColor,
                               textAlignment: .left,
                               numberOfLines: 0)
    
    let idLabel = UILabel(text: "",
                          font: .mediumFont(ofSize: 17),
                          textColor: .defaultText,
                          textAlignment: .left,
                          numberOfLines: 0)
    
    lazy var nameStack : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            nameSubLabel, idSubLabel
        ])
        sv.axis = .vertical
        sv.spacing = 9
       return sv
    }()
    
    lazy var idStack : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            idSubLabel, idLabel
        ])
        sv.axis = .vertical
        sv.spacing = 9
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestMe()
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        self.navigationController?.title = "\(nameLabel)님, 반가워요!"
        view.addSubview(profileImage)
        view.addSubview(nameStack)
        view.addSubview(idStack)
        view.addSubview(button)
        
        profileImage.anchor(
            .top(view.topAnchor, constant: height * 0.273)
        )
        nameStack.anchor(
            .top(profileImage.bottomAnchor, constant: height * 0.132),
            .leading(view.leadingAnchor, constant: width * 0.096)
        )
        idStack.anchor(
            .top(profileImage.bottomAnchor, constant: height * 0.225),
            .leading(view.leadingAnchor, constant: width * 0.096)
        )
        button.anchor(
            .top(profileImage.bottomAnchor, constant: height * 0.408)
        )
        profileImage.centerXToSuperview()
        button.centerXToSuperview()
    }
    
    fileprivate func requestMe() {
        KOSessionTask.userMeTask { [unowned self] (error, me) in
            guard
                let me = me,
                let account = me.account
                else {return}

//            self.idLabel.text = account.email
            self.nameLabel.text = me.nickname
        }
    }
}

extension ConfirmViewController: ViewModelBindableType {
    func bindViewModel(viewModel: ConfirmViewModel) {
        button.rx.action = viewModel.presentMainAction()
    }
}
