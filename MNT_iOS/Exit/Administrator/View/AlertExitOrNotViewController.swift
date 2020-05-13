//
//  AlertExitOrNotViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class AlertExitOrNotViewController: ViewController {
    
    var viewModel: AlertExitOrNotViewModel?
    var cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    var exitAction = UIAlertAction(title: "종료하기", style: .default, handler: nil)
    
    override func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        alertMessage()
    }
    
    func alertMessage() {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        let VC = AlertToAdminViewController()
    
        VC.preferredContentSize.width = 270
        VC.preferredContentSize.height = 200
        
        alert.addAction(cancelAction)
        alert.addAction(exitAction)
        alert.setValue(VC, forKey: "contentViewController")
        present(alert, animated: true, completion: nil)
    }
}

extension AlertExitOrNotViewController: ViewModelBindableType {
    func bindViewModel(viewModel: AlertExitOrNotViewModel) {
        self.cancelAction.rx.action = viewModel.cancelAction()
        exitAction.rx.action = viewModel.exitAction()
    }
}
