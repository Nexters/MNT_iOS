//
//  SetRoomTitleViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class SetRoomTitleViewController: ViewController {
    
    let Label = UILabel(text: "👻설명 추가 예정👻", numberOfLines: 0)
    let textField = UITextField(placeholder: "방 이름을 입력해주세요")
    var button = UIBarButtonItem(title: "다음", style: .plain, target: self, action: nil)
    
    var viewModel: SetRoomTitleViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = button
    }
    
    override func setupLayout() {
        
        view.stack(Label.withHeight(50),
                   textField.withHeight(50),
                   //button.withHeight(50),
                   alignment: .center)
            .withMargins(.init(top: view.frame.height/2 - 200,
                               left: 0,
                               bottom: view.frame.height/2 - 200,
                               right: 0))
    }
}

extension SetRoomTitleViewController: ViewModelBindableType {
    func bindViewModel(viewModel: SetRoomTitleViewModel) {
        textField.rx.text.orEmpty
            .bind(to: viewModel.roomTitleTextRelay)
            .disposed(by: rx.disposeBag)
        button.rx.action = viewModel.presentSetRoomDetailAction()
    }
}
