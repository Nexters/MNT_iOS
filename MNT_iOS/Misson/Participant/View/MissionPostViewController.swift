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
    fileprivate let subtitleLabel = UILabel(text: "subtitle", font: .systemFont(ofSize: 16), textColor: .defaultText)
    fileprivate let button = UIButton(title: "이미지 업로드", titleColor: .black)
    fileprivate let textfieldContainer = TextFieldContainer()
    
    fileprivate lazy var textfield: UITextField = {
        let tf = UITextField(placeholder: "텍스트를 입력해주세요.")
        tf.textAlignment = .left
        return tf
    }()
    
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
            titleStackView.withHeight(70),
            textfieldContainer.withHeight(view.bounds.height * 0.27),
        ])
        sv.axis = .vertical
        sv.spacing = 26
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activateTapGesture()
    }
    
    override func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(wholeStackView)
        view.addSubview(textfield)
        view.addSubview(button)
        
        wholeStackView.anchor(
            .top(view.topAnchor, constant: 80),
            .leading(view.leadingAnchor, constant: 40),
            .trailing(view.trailingAnchor, constant: 40))
            
        textfield.anchor(.top(textfieldContainer.topAnchor, constant: 19),
                                  .leading(textfieldContainer.leadingAnchor, constant: 24),
                                  .trailing(textfieldContainer.trailingAnchor, constant: 24),
                                  .bottom(textfieldContainer.bottomAnchor, constant: 19))
        
        button.anchor(.bottom(bottomAnchor))
        button.centerXTo(view.centerXAnchor)
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textfieldContainer.roundedBorder(corners: .allCorners, radius: 10)
    }
}

extension MissionPostViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionPostViewModel) {
        titleLabel.text = viewModel.missionName
        subtitleLabel.text = viewModel.missionDescription
        
    }
}
