//
//  FruttoAlertViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/06/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FruttoAlertViewController: UIViewController {
    var didSetupConstraints = false
    let titleLabel = UILabel(text: "",
                             font: .systemFont(ofSize: 15),
                             textColor: .defaultText,
                             textAlignment: .center,
                             numberOfLines: 0)
    var cancelButton = GrayPopUp("취소")
    var confirmButton = PrimaryPopUp("확인")
    var onCancel: (() -> Void)?
    var onConfirm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        cancelButton.addTarget(self,
                               action: #selector(pressCancelButton),
                               for: .touchUpInside)
        confirmButton.addTarget(self,
                                action: #selector(pressConfirmButton),
                                for: .touchUpInside)
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            let width = view.frame.width
            let height = view.frame.height
            
            view.addSubview(titleLabel)
            view.addSubview(cancelButton)
            view.addSubview(confirmButton)
            
            titleLabel.centerXToSuperview()
            titleLabel.anchor(
                .top(view.topAnchor, constant: height * 0.22)
            )
            cancelButton.anchor(
                .leading(view.leadingAnchor, constant: width * 0.05),
                .bottom(view.bottomAnchor, constant: 15)
            )
            confirmButton.anchor(
                .leading(view.leadingAnchor, constant: width * 0.05),
                .bottom(view.bottomAnchor, constant: 15)
            )
            
            titleLabel.constrainWidth(width * 0.9)
            titleLabel.constrainHeight(height * 0.3)
        }
        
        super.updateViewConstraints()
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    @objc func pressCancelButton() {
        defer {
            dismiss(animated: false, completion: nil)
        }
        
        let onCancel = self.onCancel
        self.onCancel = nil
        guard let block = onCancel else { return }
        block()
    }
    
    @objc func pressConfirmButton() {
        defer {
            dismiss(animated: false, completion: nil)
        }
        
        let onConfirm = self.onConfirm
        self.onConfirm = nil
        guard let block = onConfirm else { return }
        block()
    }
}
