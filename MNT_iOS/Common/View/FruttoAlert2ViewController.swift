//
//  FruttoAlert2ViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/06/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FruttoAlert2ViewController: UIViewController {
    let alertView = UIView()
    var titleLabel = UILabel(text: "앗 이건 뭐죠!\n뭐긴 뭐야\n오늘 점심 냉모밀",
                             font: .systemFont(ofSize: 15),
                             textColor: .defaultText,
                             textAlignment: .center,
                             numberOfLines: 0)
    var cancelButton = UIButton()
    var confirmButton = UIButton()
    var onCancel: (() -> Void)?
    var onConfirm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        alertView.backgroundColor = .white
        alertView.frame = CGRect(x: Int(width * 0.099),
                                 y: Int(height * 0.357),
                                 width: Int(width * 0.803),
                                 height: Int(height * 0.286))
        alertView.layer.cornerRadius = 10.0
        
        cancelButton.backgroundColor = .grayColor
        cancelButton.setTitleColor(.textOnlyColor, for: .normal)
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.frame = CGRect(x: width * 0.139,
                                    y: height * 0.57,
                                    width: width * 0.344,
                                    height: height * 0.057)
        cancelButton.layer.cornerRadius = 10.0
        
        confirmButton.backgroundColor = .primaryColor
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.frame = CGRect(x: width * 0.517,
                                    y: height * 0.57,
                                    width: width * 0.344,
                                    height: height * 0.057)
        confirmButton.layer.cornerRadius = 10.0
        
        titleLabel.frame = CGRect(x: width * 0.15,
                                  y: height * 0.417,
                                  width: width * 0.704,
                                  height: height * 0.092)
        titleLabel.setLineSpacing(lineSpacing: 2)
        titleLabel.textAlignment = .center
        
        self.view.addSubview(alertView)
        self.view.addSubview(cancelButton)
        self.view.addSubview(confirmButton)
        self.view.addSubview(titleLabel)

        self.view.bringSubviewToFront(cancelButton)
        self.view.bringSubviewToFront(confirmButton)
        self.view.bringSubviewToFront(titleLabel)

        cancelButton.addTarget(self,
                               action: #selector(pressCancelButton),
                               for: .touchUpInside)
        confirmButton.addTarget(self,
                                action: #selector(pressConfirmButton),
                                for: .touchUpInside)
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
