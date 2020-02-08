//
//  AlertExitOrNotViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class AlertExitOrNotViewController: ViewController {
    
    var viewModel: AlertExitOrNotViewModel?
    let label = UILabel(text: "마니또 종료", numberOfLines: 0)
    var button = UIButton(title: "버튼", titleColor: .black)

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
        view.stack(label,
                   button.withHeight(50),
                   alignment: .center,
                   distribution: .fillEqually)
            .withMargins(.init(top: 100,
                               left: 0,
                               bottom: 100,
                               right: 0))
        
//        let alert = UIAlertController(title: "Alert", message: nil, preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(action)
//        present(alert, animated: true, completion: nil)
        
    }
}

extension AlertExitOrNotViewController: ViewModelBindableType {
    func bindViewModel(viewModel: AlertExitOrNotViewModel) {
    
        //button.rx.action = viewModel.openAlertAction()
    }
}
