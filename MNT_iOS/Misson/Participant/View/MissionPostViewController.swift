//
//  MissionDetailViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MissionPostViewController: ViewController {
    var viewModel: MissionPostViewModel?
    fileprivate let titleLabel = UILabel(text: "title", font: .boldSystemFont(ofSize: 20))
    fileprivate let subtitleLabel = UILabel(text: "subtitle")
    fileprivate let textfield = UITextField(placeholder: "텍스트 입력")
    fileprivate let button = UIButton(title: "이미지 업로드", titleColor: .black)
    fileprivate var barbutton = UIBarButtonItem(title: "다음",
                                                style: .done,
                                                target: nil,
                                                action: nil)
    
    fileprivate lazy var titleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])
        sv.axis = .vertical
        return sv
    }()
    
    fileprivate lazy var wholeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleStackView.withHeight(100),
            textfield.withHeight(100),
            button.withHeight(50)
        ])
        sv.axis = .vertical
        return sv
    }()
    
    override func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(wholeStackView)
        
        wholeStackView.anchor(
            .top(view.topAnchor, constant: 80),
            .leading(view.leadingAnchor, constant: 40),
            .trailing(view.trailingAnchor, constant: 40))
        
        wholeStackView.constrainHeight(300)
    }
    
    override func setupNavigationController() {
        navigationItem.setRightBarButton(barbutton, animated: true)
    }
}

extension MissionPostViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionPostViewModel) {
        barbutton.rx.action = viewModel.missionPreviewAction(content: "",     imageURL: "")
    }
}
