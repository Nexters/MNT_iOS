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
    var joinButton = UIButton(title: "참여하기", titleColor: .black)
    var produceButton = UIButton(title: "방 만들기", titleColor: .black)
    
    var viewModel: MainViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupLayout() {
        view.stack(joinButton.withHeight(50),
                   produceButton.withHeight(50),
                   alignment: .center,
                   distribution: .fillEqually)
            .withMargins(.init(top: view.frame.height/2 - 200,
                               left: 0,
                               bottom: view.frame.height/2 - 200,
                               right: 0))
    }
}

extension MainViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MainViewModel) {
        joinButton.rx.action = viewModel.presentJoinAction()
        produceButton.rx.action = viewModel.presentSetAction()
    }
}
