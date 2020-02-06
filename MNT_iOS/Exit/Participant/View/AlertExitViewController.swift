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
    let titleLabel = UILabel(text: "마니또 종료", numberOfLines: 0)
    let descriptionLabel = UILabel(text: "아쉽게도 마니또 종료일이 다가왔습니다.\n즐겁고 행복한 시간이 되셨길 바랍니다.\n\n자, 그럼 이제\n내또를 확인할 시간입니다 :D", numberOfLines: 0)
    var button = UIButton(title: "확인", titleColor: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupLayout() {
        descriptionLabel.textAlignment = .center
        
        view.stack(titleLabel,
                   descriptionLabel,
                   button.withHeight(50),
                   alignment: .center,
                   distribution: .fillEqually)
            .withMargins(.init(top: view.frame.height/2 - 200,
                               left: 0,
                               bottom: view.frame.height/2 - 200,
                               right: 0))
    }
}

extension AlertExitViewController: ViewModelBindableType {
    func bindViewModel(viewModel: AlertExitViewModel) {
        button.rx.action = viewModel.presentGuessAction()
    }
}
