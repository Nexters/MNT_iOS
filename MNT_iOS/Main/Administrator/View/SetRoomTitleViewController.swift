//
//  SetRoomTitleViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class SetRoomTitleViewController: ViewController {
    
    var viewModel: SetRoomTitleViewModel?
    let label = UILabel(text: "프루또 방 이름을 만들어 주세요🍇",
                        font: .systemFont(ofSize: 18),
                        textColor: .defaultText,
                        textAlignment: .left,
                        numberOfLines: 0)
    let textField = UITextField(placeholder: "Enter")
    var nextButton = PrimaryButton("다음")

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
            .top(label.bottomAnchor, constant: height * 0.05),
            .leading(view.leadingAnchor, constant: width * 0.08)
        )
        nextButton.anchor(.top(label.bottomAnchor, constant: height * 0.155))
        nextButton.centerXToSuperview()
    }
}

extension SetRoomTitleViewController: ViewModelBindableType {
    func bindViewModel(viewModel: SetRoomTitleViewModel) {
        textField.rx.text.orEmpty
            .bind(to: viewModel.roomTitleTextRelay)
            .disposed(by: rx.disposeBag)
        
        nextButton.rx.action = viewModel.presentSetRoomDetailAction()
    }
}
