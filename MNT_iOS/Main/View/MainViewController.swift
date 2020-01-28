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

class MainViewController: ViewController {
    
    let nicknameLabel = UILabel(text: "",
                                 font: .systemFont(ofSize: 20),
                                 textAlignment: .center,
                                 numberOfLines: 0)
    let profileImageView = CircularImageView(width: 100)
    
    let button = UIButton(title: "Gogo", titleColor: .black)
    let textfield = UITextField(placeholder: "아무거나 입력하시던지요.")
    let mimicLabel = UILabel(text: "난 따라하지 !", numberOfLines: 0)
    
    var viewModel: MainViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        requestMe()
    }

    override func setupLayout() {
        view.stack(profileImageView,
                   nicknameLabel.withHeight(50),
                   textfield.withHeight(50),
                   mimicLabel.withHeight(50),
                   button.withHeight(50),
                   alignment: .center)
            .withMargins(.init(top: view.frame.height/2 - 200,
                               left: 0,
                               bottom: view.frame.height/2 - 200,
                               right: 0))
    }
    
    fileprivate func requestMe() {
        KOSessionTask.userMeTask { [unowned self] (error, me) in
            guard
                let me = me,
                let account = me.account,
                let profileImageUrl = account.profile?.profileImageURL
                else {return}
            
            self.nicknameLabel.text = me.nickname
            self.profileImageView.kf.setImage(with: profileImageUrl)
        }
    }
}

extension MainViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        textfield.rx.text.orEmpty
            .bind(to: viewModel.textfieldRelay)
            .disposed(by: rx.disposeBag)
        
//        button.rx.action = viewModel.
    }
}
