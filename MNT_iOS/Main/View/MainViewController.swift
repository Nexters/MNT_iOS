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
    var viewModel: MainViewModel?
    let logoImage = UIImageView(image: #imageLiteral(resourceName: "frutto1"))
    let label = UILabel(text: "초대코드를 받았다면 참여하기로 입장해주세요.",
                        font: .mediumFont(ofSize: 13),
                        textColor: .black,
                        textAlignment: .center,
                        numberOfLines: 0)
    var joinButton = PrimaryButton("참여하기🤝")
    var produceButton = SubButton("방 만들기🙋‍♀️")
    let leftButton: UIBarButtonItem = {
        let bt = UIBarButtonItem(image: #imageLiteral(resourceName: "arrowLeft"), style: .plain, target: nil, action: nil)
        bt.tintColor = .defaultText
        return bt
    }()
        
    override func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.leftBarButtonItem = leftButton
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(logoImage)
        view.addSubview(label)
        view.addSubview(joinButton)
        view.addSubview(produceButton)
        
        logoImage.anchor(
            .top(view.topAnchor, constant: height * 0.217)
        )
        
        logoImage.constrainWidth(height * 0.273)
        logoImage.constrainHeight(height * 0.298)
        label.anchor(.top(logoImage.bottomAnchor, constant: height * 0.179))
        joinButton.anchor(.top(logoImage.bottomAnchor, constant: height * 0.214))
        produceButton.anchor(.top(logoImage.bottomAnchor, constant: height * 0.313))
        
        logoImage.centerXToSuperview()
        label.centerXToSuperview()
        joinButton.centerXToSuperview()
        produceButton.centerXToSuperview()
    }
}

extension MainViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MainViewModel) {
//        viewModel.test()
        viewModel.checkKakaoLinkParams()
        
        joinButton.rx.action = viewModel.presentJoinAction()
        produceButton.rx.action = viewModel.presentSetAction()
    }
}
