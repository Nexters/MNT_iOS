//
//  ReadyViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class ReadyViewController: ViewController {
    
    let room : Room = UserDefaults.standard.getObject(key: .room)!
    var isAdmin : Bool = false
    var isStarted: Bool = true
    var dummyDate: String = "2020.01.20. (월)"
    var viewModel: ReadyViewModel?
    let fruitImage = UIImageView(image: #imageLiteral(resourceName: "fruits"))
    let titleLabel = UILabel(text: "방이름글자수제한은열다섯이야",
                             font: .systemFont(ofSize: 22),
                             textColor: .defaultText,
                             textAlignment: .center,
                             numberOfLines: 0)
    let subLabel = UILabel(text: "",
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if let user : User = UserDefaults.standard.getObject(key: .user) {
            APISource.shared.getRoomCheck(userId: user.id) { (roomCheck) in
                print("Success : getRoomCheck")
                if (roomCheck![0].userFruttoId == nil) {
                    self.isStarted = false
                    
                } else {
                    self.isStarted = true
                    UserDefaults.standard.setObject(object: roomCheck![0].manitto, key: .manitto)
                    UserDefaults.standard.setIntValue(value: roomCheck![0].userFruttoId!, key: .userFruttoId)
                }
                self.setUpForParticipant()
            }
        } else {
            print("Fail : getObject(key: .user)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
//        if isAdmin != true {
//            setUpForParticipant()
//        }
//        else {
//            setUpForAdministrator()
//        }
        
        view.addSubview(fruitImage)
        view.addSubview(titleLabel)
        view.addSubview(sendButton)
        view.addSubview(startButton)
        view.addSubview(checkButton)
        
        fruitImage.anchor(.top(view.topAnchor, constant: height * 0.2))
        titleLabel.anchor(.top(view.topAnchor, constant: height * 0.28))
        sendButton.anchor(.bottom(view.bottomAnchor, constant: height * 0.25))
        startButton.anchor(.bottom(view.bottomAnchor, constant: height * 0.15))
        checkButton.anchor(.bottom(view.bottomAnchor, constant: height * 0.05))
        
        fruitImage.centerXToSuperview()
        titleLabel.centerXToSuperview()
        bubbleImage.centerXToSuperview()
        subLabel.centerXToSuperview()
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
    
    func setUpForParticipant() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(bubbleImage)
        view.addSubview(subLabel)
        
        bubbleImage.anchor(.top(view.topAnchor, constant: height * 0.32))
        subLabel.anchor(.top(view.topAnchor, constant: height * 0.333))
        
        bubbleImage.centerXToSuperview()
        subLabel.centerXToSuperview()
        
        bubbleImage.transform = CGAffineTransform(rotationAngle: .pi)
        
        setUpDetailForParticipant()
    }
    
    func setUpForAdministrator() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(bubbleImage)
        view.addSubview(subLabel)
        view.addSubview(codeSubLabel)
        view.addSubview(codeLabel)
        
        bubbleImage.anchor(.top(view.topAnchor, constant: height * 0.33))
        subLabel.anchor(.top(view.topAnchor, constant: height * 0.33))
        codeSubLabel.anchor(.top(view.topAnchor, constant: height * 0.5))
        codeLabel.anchor(.top(codeSubLabel.topAnchor, constant: 20))
        
        codeSubLabel.centerXToSuperview()
        codeLabel.centerXToSuperview()
        
        setUpDetailForAdministrator()
    }
    
    func setUpDetailForAdministrator() {
        subLabel.text = "프루또방이 생성되었습니다.\n초대코드를 공유해서 친구들을 초대하세요."
    }
    
    func setUpDetailForParticipant() {
        var frontText = "\(room.startDay) 정오"
        var backText : String?
        
        titleLabel.text = room.name
        
        if isStarted == false {
            startButton.isUserInteractionEnabled = false
            startButton.backgroundColor = .disableColor
            backText = "에 시작합니다.\n친구들이 모일 때까지 잠시 기다려주세요👏"
        } else {
            backText = "에 시작되었습니다!\n친구들과 함께 프루또를 해볼까요?👏"
        }
        
        subLabel.text = frontText + backText!
        
        let attributedStr = NSMutableAttributedString(string: subLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7
        paragraphStyle.alignment = .center
        attributedStr.addAttribute(.foregroundColor,
                                   value: UIColor.textOnlyColor,
                                   range: (subLabel.text! as NSString).range(of: frontText))
        attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle,
                                   value:paragraphStyle,
                                   range:NSMakeRange(0, attributedStr.length))
        subLabel.attributedText = attributedStr
    }
}

extension ReadyViewController: ViewModelBindableType {
    func bindViewModel(viewModel: ReadyViewModel) {
        sendButton.rx.action = viewModel.sendKakaoLinkAction()
        startButton.rx.action = viewModel.enterRoom()
        checkButton.rx.action = viewModel.presentShowAction()
    }
}
