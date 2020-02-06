//
//  JoinViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class JoinRoomViewController: ViewController {

    var viewModel: JoinRoomViewModel?
    var textField = UITextField(placeholder: "초대코드입력")
    var button = UIBarButtonItem(title: "다음", style: .plain, target: self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = button
    }
    
    override func setupLayout() {
        view.stack(textField.withHeight(50),
                   alignment: .center)
            .withMargins(.init(top: view.frame.height/2 - 200,
                               left: 0,
                               bottom: view.frame.height/2 - 200,
                               right: 0))
    }
    
}

extension JoinRoomViewController: ViewModelBindableType {
    func bindViewModel(viewModel: JoinRoomViewModel) {
        textField.rx.text.orEmpty
            .bind(to: viewModel.codeTextRelay)
            .disposed(by: rx.disposeBag)
        button.rx.action = viewModel.presentReadyAction()
    }
}
