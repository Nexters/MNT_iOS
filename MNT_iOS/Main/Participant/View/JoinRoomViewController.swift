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
    let label = UILabel(text: "초대코드를 입력해주세요 💌",
                        font: .systemFont(ofSize: 18),
                        textColor: .defaultText,
                        textAlignment: .left,
                        numberOfLines: 0)
    let textField : UITextField = {
        let tf = UITextField(placeholder: "Enter")
        tf.keyboardType = .numberPad
        return tf
    }()
    var nextButton = PrimaryButton("입장하기")
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(nextButton)
        
        label.anchor(
            .top(view.topAnchor, constant: height * 0.307),
            .leading(view.leadingAnchor, constant: width * 0.08)
        )
        textField.anchor(
            .top(label.bottomAnchor, constant: height * 0.047),
            .leading(view.leadingAnchor, constant: width * 0.08)
        )
        nextButton.anchor(
            .top(label.bottomAnchor, constant: height * 0.155)
        )
        nextButton.centerXToSuperview()
    }
}

extension JoinRoomViewController: ViewModelBindableType {
    func bindViewModel(viewModel: JoinRoomViewModel) {
        textField.rx.text.orEmpty
            .bind(to: viewModel.codeTextRelay)
            .disposed(by: rx.disposeBag)
        nextButton.rx.action = viewModel.presentReadyAction()
    }
}
