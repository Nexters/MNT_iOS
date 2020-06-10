//
//  FruttoAlert2ViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/06/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FruttoAlert1ViewController: UIViewController {
    let alertView = UIView()
    var titleLabel = UILabel(text: "앗 이건 뭐죠!\n뭐긴 뭐야\n오늘 점심 냉모밀",
                             font: .systemFont(ofSize: 15),
                             textColor: .defaultText,
                             textAlignment: .center,
                             numberOfLines: 0)
    var confirmButton = UIButton()
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
        
        confirmButton.backgroundColor = .primaryColor
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.frame = CGRect(x: width * 0.139,
                                    y: height * 0.561,
                                    width: width * 0.722,
                                    height: height * 0.061)
        confirmButton.layer.cornerRadius = 10.0
        
        titleLabel.frame = CGRect(x: width * 0.15,
                                  y: height * 0.417,
                                  width: width * 0.704,
                                  height: height * 0.092)
        titleLabel.setLineSpacing(lineSpacing: 2)
        titleLabel.textAlignment = .center
        
        self.view.addSubview(alertView)
        self.view.addSubview(confirmButton)
        self.view.addSubview(titleLabel)

        self.view.bringSubviewToFront(confirmButton)
        self.view.bringSubviewToFront(titleLabel)
        confirmButton.addTarget(self,
                                action: #selector(pressConfirmButton),
                                for: .touchUpInside)
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
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

