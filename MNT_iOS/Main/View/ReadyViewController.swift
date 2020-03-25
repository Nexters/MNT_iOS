//
//  ReadyViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class ReadyViewController: ViewController {
    
    var viewModel: ReadyViewModel?
    let fruitImage = UIImageView(image: #imageLiteral(resourceName: "fruits"))
    let titleLabel = UILabel(text: "방이름글자수제한은열다섯이야",
                             font: .systemFont(ofSize: 22),
                             textColor: .defaultText,
                             textAlignment: .center,
                             numberOfLines: 0)
    let subLabel = UILabel(text: "프루또방이 생성되었습니다.\n초대코드를 공유해서 친구들을 초대하세요.",
                           font: .systemFont(ofSize: 15),
                           textColor: .subLabelColor,
                           textAlignment: .center,
                           numberOfLines: 0)
    let bubbleImage = UIImageView(image: #imageLiteral(resourceName: "combinedShape"))
    let codeSubLabel = UILabel(text: "초대코드",
                               font: .systemFont(ofSize: 15),
                               textColor: .subLabelColor,
                               textAlignment: .center,
                               numberOfLines: 0)
    let codeLabel = UILabel(text: "99999",
                            font: .boldFont(ofSize: 24),
                            textColor: .subLabelColor,
                            textAlignment: .center,
                            numberOfLines: 0)
    var sendButton = PrimaryButton("카카오톡 초대장 보내기 🤝")
    var startButton = PrimaryButton("시작하기 🙋‍♀️")
    var checkButton = TextOnlyButton("참여자 보기 👭")
    
    override func setupNavigationController() {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(fruitImage)
        view.addSubview(titleLabel)
        view.addSubview(bubbleImage)
        view.addSubview(subLabel)
        view.addSubview(codeSubLabel)
        view.addSubview(codeLabel)
        view.addSubview(sendButton)
        view.addSubview(startButton)
        view.addSubview(checkButton)
        
        fruitImage.anchor(.top(view.topAnchor, constant: height * 0.2))
        titleLabel.anchor(.top(view.topAnchor, constant: height * 0.2 + 50))
        bubbleImage.anchor(.top(view.topAnchor, constant: height * 0.33))
        subLabel.anchor(.top(view.topAnchor, constant: height * 0.33))
        codeSubLabel.anchor(.top(view.topAnchor, constant: height * 0.5))
        codeLabel.anchor(.top(codeSubLabel.topAnchor, constant: 20))
        sendButton.anchor(.bottom(view.bottomAnchor, constant: height * 0.25))
        startButton.anchor(.bottom(view.bottomAnchor, constant: height * 0.15))
        checkButton.anchor(.bottom(view.bottomAnchor, constant: height * 0.05))
        
        fruitImage.centerXToSuperview()
        titleLabel.centerXToSuperview()
        bubbleImage.centerXToSuperview()
        subLabel.centerXToSuperview()
        codeSubLabel.centerXToSuperview()
        codeLabel.centerXToSuperview()
        sendButton.centerXToSuperview()
        startButton.centerXToSuperview()
        checkButton.centerXToSuperview()
        
        fruitImage.constrainWidth(78)
        fruitImage.constrainHeight(41)
        bubbleImage.constrainWidth(width * 0.78)
        bubbleImage.constrainHeight(height * 0.15)
        subLabel.constrainWidth(width * 0.75)
        subLabel.constrainHeight(height * 0.14)
    }
}

extension ReadyViewController: ViewModelBindableType {
    func bindViewModel(viewModel: ReadyViewModel) {
        sendButton.rx.action = viewModel.sendKakaoLinkAction()
        startButton.rx.action = viewModel.enterRoom()
        checkButton.rx.action = viewModel.presentShowAction()
    }
}
