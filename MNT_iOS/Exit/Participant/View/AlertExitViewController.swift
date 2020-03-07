//
//  AlertExitViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/05.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class AlertExitViewController: ViewController {
    
    var viewModel: AlertExitViewModel?
    let subLabel = UILabel(text: "아쉽게도 푸르또 종료일이 다가왔습니다.😢\n즐겁고 행복한 시간이 되셨길 바랍니다.",
                           font: .mediumFont(ofSize: 15),
                           textColor: .subLabelColor,
                           textAlignment: .center,
                           numberOfLines: 0)
    let bubbleImage = UIImageView(image: #imageLiteral(resourceName: "combinedShape"))
    let presentImage = UIImageView(image: #imageLiteral(resourceName: "invalidName"))
    let label = UILabel(text: "자, 그럼 이제\n내또를 확인할 시간입니다!",
                        font: .semiBoldFont(ofSize: 16),
                        textColor: .defaultText,
                        textAlignment: .center,
                        numberOfLines: 0)
    var button = PrimaryButton("확인")
    
    override func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(presentImage)
        view.addSubview(bubbleImage)
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(subLabel)
        
        presentImage.centerInSuperview()
        bubbleImage.centerXToSuperview()
        label.centerXToSuperview()
        button.centerXToSuperview()
        
        bubbleImage.anchor(.bottom(presentImage.topAnchor, constant: height * 0.044))
        label.anchor(.top(presentImage.bottomAnchor, constant: height * 0.018))
        button.anchor(.top(presentImage.bottomAnchor, constant: height * 0.368))
        subLabel.anchor(.bottom(bubbleImage.bottomAnchor, constant: height * 0.038))
        subLabel.centerXTo(bubbleImage.centerXAnchor)
        
        presentImage.constrainWidth(50)
        presentImage.constrainHeight(50)
        bubbleImage.constrainWidth(width * 0.84)
        bubbleImage.constrainHeight(height * 0.11)
        button.constrainWidth(width * 0.893)
        button.constrainHeight(height * 0.078)
    }
}

extension AlertExitViewController: ViewModelBindableType {
    func bindViewModel(viewModel: AlertExitViewModel) {
        button.rx.action = viewModel.presentGuessAction()
    }
}
