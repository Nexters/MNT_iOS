//
//  MissionTypeView.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionTypeView: UIView {
    let markLabel = UILabel(text: "#",
                       font: .systemFont(ofSize: 13),
                       textColor: .semiAccentColor)
    
    let missionNameLabel = UILabel(text: "닮은꼴 사진 보내기",
                                   font: .boldSystemFont(ofSize: 12),
                                   textColor: .accentColor)
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [markLabel, missionNameLabel])
        
        let subView = UIView(frame: sv.bounds)
        subView.layer.cornerRadius = 10
        subView.backgroundColor = UIColor.accentColor.withAlphaComponent(0.16)
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sv.insertSubview(subView, at: 0)
        
        sv.axis = .horizontal
        sv.spacing = 5
        
        sv.isLayoutMarginsRelativeArrangement = true
        sv.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        return sv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(stackView)
        stackView.anchor(
            .top(topAnchor),
            .leading(leadingAnchor),
            .bottom(bottomAnchor)
        )
    }
}
