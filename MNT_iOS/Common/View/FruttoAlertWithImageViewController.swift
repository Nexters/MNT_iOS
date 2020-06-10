//
//  FruttoAlert2ViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/06/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FruttoAlertWithImageViewController: UIViewController {
    let alertView = UIView()
    var titleLabel = UILabel(text: "당신의 마니또는?",
                             font: .systemFont(ofSize: 20),
                             textColor: .defaultText,
                             textAlignment: .center,
                             numberOfLines: 0)
    var confirmButton = UIButton()
    var nameImage = UIImageView(image: FruitImage.sharedInstance.getFruitPopUp(3))
    var nameLabel = UILabel(text: "프루또",
                            font: .mediumFont(ofSize: 16),
                            textColor: .defaultText,
                            textAlignment: .center,
                            numberOfLines: 0)
    var onConfirm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        alertView.backgroundColor = .white
        alertView.frame = CGRect(x: width * 0.098,
                                 y: height * 0.274,
                                 width: width * 0.802,
                                 height: height * 0.421)
        alertView.layer.cornerRadius = 10.0
        
        confirmButton.backgroundColor = .grayColor
        confirmButton.setTitleColor(.textOnlyColor, for: .normal)
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.frame = CGRect(x: width * 0.138,
                                    y: height * 0.615,
                                    width: width * 0.722,
                                    height: height * 0.061)
        confirmButton.layer.cornerRadius = 10.0
        
        titleLabel.frame = CGRect(x: width * 0.15,
                                  y: height * 0.324,
                                  width: width * 0.704,
                                  height: 20)
        titleLabel.textAlignment = .center
        
        nameImage.frame = CGRect(x: width/2 - 94,
                                 y: height * 0.369,
                                 width: 188,
                                 height: 162)
        nameLabel.frame = CGRect(x: width/2 - 42,
                                 y: height * 0.369 + 57,
                                 width: 84,
                                 height: 16)
        
        self.view.addSubview(alertView)
        self.view.addSubview(confirmButton)
        self.view.addSubview(titleLabel)
        self.view.addSubview(nameImage)
        self.view.addSubview(nameLabel)

        self.view.bringSubviewToFront(confirmButton)
        self.view.bringSubviewToFront(titleLabel)
        self.view.bringSubviewToFront(nameImage)
        self.view.bringSubviewToFront(nameLabel)
        
        confirmButton.addTarget(self,
                                action: #selector(pressConfirmButton),
                                for: .touchUpInside)
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    func setManitto(manittoName: String, manittoFruttoId: Int) {
        nameImage = UIImageView(image: FruitImage.sharedInstance.getFruitPopUp(manittoFruttoId))
        nameLabel.text = manittoName
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

