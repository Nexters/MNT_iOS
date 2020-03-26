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
    let label = UILabel(text: "초대코드를 입력해주세요💌",
                        font: .boldFont(ofSize: 18),
                        textColor: .defaultText,
                        textAlignment: .left,
                        numberOfLines: 0)
    let textField : UITextField = {
        let tf = UITextField()
        tf.placeholder = ""
        tf.keyboardType = .numberPad
        return tf
    }()
    
    var countLabel = UILabel(text: "0/5",
                             font: .mediumFont(ofSize: 13),
                             textColor: .lightGray)
    var nextButton = PrimaryButton("입장하기")
    
    let leftButton: UIBarButtonItem = {
        let bt = UIBarButtonItem(image: #imageLiteral(resourceName: "close"),
                                 style: .plain,
                                 target: self,
                                 action: #selector(backButtonPressed(_:)))
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
        
        view.addSubview(label)
        view.addSubview(textField)
        view.addSubview(nextButton)
        view.addSubview(countLabel)
        
        label.anchor(
            .top(view.topAnchor, constant: height * 0.307),
            .leading(view.leadingAnchor, constant: width * 0.08)
        )
        textField.anchor(
            .top(label.bottomAnchor, constant: height * 0.05),
            .leading(view.leadingAnchor, constant: width * 0.08)
        )
        countLabel.anchor(
            .top(textField.bottomAnchor, constant: 5),
            .trailing(view.trailingAnchor, constant: width * (0.08))
        )
        textField.constrainWidth(width * 0.84)
        textField.constrainHeight(25.5)
        nextButton.anchor(.top(label.bottomAnchor, constant: height * 0.155))
        nextButton.centerXToSuperview()
    }
    
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(1.0)
        
        textField.clearButtonMode = .always
        
        border.borderColor = UIColor.moreText.cgColor
        border.frame = CGRect(x: 0,
                              y: textField.frame.size.height - width,
                              width:  textField.frame.size.width,
                              height: textField.frame.size.height)
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
    @objc private func backButtonPressed(_ sender: Any) {
        print("clicked back")
        self.navigationController?.popViewController(animated: true)
    }
}

extension JoinRoomViewController: ViewModelBindableType {
    func bindViewModel(viewModel: JoinRoomViewModel) {
        textField.text = viewModel.kakaoLinkParams
        
        textField.rx.text.orEmpty
            .bind(to: viewModel.codeTextRelay)
            .disposed(by: rx.disposeBag)

        nextButton.rx.action = viewModel.presentReadyAction()

        textField.rx.controlEvent(.editingChanged)
            .subscribe(onNext: { [unowned self] in
                if let text = self.textField.text {
                    self.countLabel.text = String(text.count) + "/5"
                }
            }).disposed(by: rx.disposeBag)
    }
}
