//
//  OpenNittoViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class OpenNittoViewController: ViewController {

    let user: User = UserDefaults.standard.getObject(key: .user)!
    let room: Room = UserDefaults.standard.getObject(key: .room)!
    
    var viewModel: OpenNittoViewModel?
    let label = UILabel(text: "",
                        font: .boldFont(ofSize: 18),
                        textColor: .primaryColor,
                        textAlignment: .center,
                        numberOfLines: 0)
    let frontLabelString = "님의 마니또는 "
    let backLabelString = "님입니다."
    var myProfileImage = UIImageView(image: #imageLiteral(resourceName: "profileFace01"))
    var nittoProfileImage = UIImageView(image: #imageLiteral(resourceName: "profileFace01"))
    let arrowImage = UIImageView(image: #imageLiteral(resourceName: "arrowRelation"))
    var myNameLabel = UILabel(text: "",
                              font: .semiBoldFont(ofSize: 15),
                              textColor: .defaultText,
                              textAlignment: .center,
                              numberOfLines: 0)
    var nittoNameLabel = UILabel(text: "",
                                 font: .semiBoldFont(ofSize: 15),
                                 textColor: .defaultText,
                                 textAlignment: .center,
                                 numberOfLines: 0)
    var subLabelView = UIView(backgroundColor: .white)
    var subLabel = UILabel(text: "",
                           font: .subSemiBoldFont(ofSize: 15),
                           textColor: .primaryColor,
                           textAlignment: .center,
                           numberOfLines: 0)
    let subLabelString = " 정오 까지 프루또 친구를\n많이 많이 챙겨주세요! 💌"
    var button = PrimaryButton("확인")
    var myName : String?
    var nittoName : String?
    var date : String?
    
    var backButton: UIBarButtonItem = {
        let bt = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: nil, action: nil)
        bt.tintColor = .defaultText
        return bt
    }()
    
    lazy var relationStack : UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
            myProfileImage, arrowImage, nittoProfileImage
       ])
        sv.axis = .horizontal
        sv.spacing = 50
        sv.alignment = .center
        return sv
    }()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           navigationController?.navigationBar.isHidden = false
    }
        
    override func setupNavigationController() {
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "내 푸르또는 누구일까요?"
    }
    
    override func setupLayout() {
        let height = view.frame.height
        let width = view.frame.width
        
        setupLabel()
        
        view.addSubview(label)
        view.addSubview(relationStack)
        view.addSubview(myNameLabel)
        view.addSubview(nittoNameLabel)
        view.addSubview(subLabelView)
        view.addSubview(button)
        
        label.anchor(.top(view.topAnchor, constant: height * 0.291))
        relationStack.anchor(.top(view.topAnchor, constant: height * 0.4))
        myNameLabel.anchor(.top(myProfileImage.bottomAnchor, constant: 10))
        nittoNameLabel.anchor(.top(nittoProfileImage.bottomAnchor, constant: 10))
        subLabelView.anchor(.top(label.bottomAnchor, constant: height * 0.35))
        button.anchor(.top(label.bottomAnchor, constant: height * 0.474))
        label.centerXToSuperview()
        relationStack.centerXToSuperview()
        myNameLabel.centerXTo(myProfileImage.centerXAnchor)
        nittoNameLabel.centerXTo(nittoProfileImage.centerXAnchor)
        subLabelView.centerXToSuperview()
        button.centerXToSuperview()
        myProfileImage.constrainWidth(80)
        myProfileImage.constrainHeight(80)
        nittoProfileImage.constrainWidth(80)
        nittoProfileImage.constrainHeight(80)
        arrowImage.constrainWidth(60)
        arrowImage.constrainHeight(30)
        subLabelView.constrainWidth(width * 0.84)
        subLabelView.constrainHeight(height * 0.097)
        subLabel.constrainHeight(height * 0.097)
    }
    
    func setupLabel() {
        // TODO : 내 이름, 니또 이름, 종료 날짜 받아오기
        APISource.shared.getRoomCheck(userId: user.id) { (roomCheck) in
            let roomNum: Int = roomCheck?.count ?? 0
            if roomNum > 0 {
                let index = roomNum - 1 // 마지막으로 참가한 방의 인덱스
                
                self.nittoName = roomCheck![index].manitto.name
                self.myName = self.user.name
                self.date = self.room.endDay
                self.myProfileImage.image = FruitImage.sharedInstance.getFruitCircle(roomCheck![index].userFruttoId ?? 2)
                self.nittoProfileImage.image = FruitImage.sharedInstance.getProfileFace(roomCheck![index].manitto.fruttoId ?? 2)
                
                self.label.text = self.myName! + self.frontLabelString + self.nittoName! + self.backLabelString
                self.subLabel.text = self.date! + self.subLabelString
                self.myNameLabel.text = self.myName
                self.nittoNameLabel.text = self.nittoName
                
                var attributedStr = NSMutableAttributedString(string: self.label.text!)
                let paragraphStyle = NSMutableParagraphStyle()
                attributedStr.addAttribute(.foregroundColor,
                                           value: UIColor.defaultText,
                                           range: (self.label.text! as NSString).range(of: self.frontLabelString))
                attributedStr.addAttribute(.foregroundColor,
                                           value: UIColor.defaultText,
                                           range: (self.label.text! as NSString).range(of: self.backLabelString))
                self.label.attributedText = attributedStr
                
                attributedStr = NSMutableAttributedString(string: self.subLabel.text!)
                paragraphStyle.lineSpacing = 7
                paragraphStyle.alignment = .center
                attributedStr.addAttribute(.foregroundColor,
                                           value: UIColor.subLabelColor,
                                           range: (self.subLabel.text! as NSString).range(of: self.subLabelString))
                attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle,
                                           value:paragraphStyle,
                                           range:NSMakeRange(0, attributedStr.length))
                self.subLabel.attributedText = attributedStr
                
                self.subLabelView.stack(self.subLabel)
                self.subLabelView.layer.masksToBounds = false
                self.subLabelView.backgroundColor = .white
                self.subLabelView.layer.cornerRadius = 20
                self.subLabelView.setupShadow(opacity: 0.15,
                                         radius: 20,
                                         offset: .init(width: 0, height: 3))
            }
        }
    }
}

extension OpenNittoViewController: ViewModelBindableType {
    func bindViewModel(viewModel: OpenNittoViewModel) {
        button.rx.action = viewModel.presentTabBarAction()
        
    }
}
