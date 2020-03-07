//
//  AlerttoAdminViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/18.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class AlertToAdminViewController : ViewController {
    
    let label = UILabel(text: "푸르또를 종료하시겠습니까?\n참가자들의 푸르또가 공개됩니다.",
                        font: .semiBoldFont(ofSize: 15),
                        textColor: .defaultText,
                        textAlignment: .center,
                        numberOfLines: 0)
    var cancelButton = GrayPopUp("취소")
    var exitButton = PrimaryPopUp("종료하기")
    
    override func setupLayout() {
        let width : CGFloat = 270
        let height : CGFloat = 208
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view = containerView

        view.addSubview(label)
//        view.addSubview(cancelButton)
//        view.addSubview(exitButton)
        
        label.anchor(
            .top(view.topAnchor, constant: height * 0.272)
        )
//        cancelButton.anchor(
//            .bottom(view.bottomAnchor, constant: height * 0.06),
//            .leading(view.leadingAnchor, constant: width * 0.05)
//        )
//        exitButton.anchor(
//            .bottom(view.bottomAnchor, constant: height * 0.06),
//            .trailing(view.trailingAnchor, constant: width * 0.05)
//        )
        
        label.centerXToSuperview()
    }
}
