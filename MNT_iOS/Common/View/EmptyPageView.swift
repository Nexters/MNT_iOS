//
//  EmptyPage.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/05/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

enum EmptyPageType {
    case feed, missionParticipant
}

extension EmptyPageType {
    var text: String {
        switch self {
        case .feed:
            return "미션을 등록해주세요!\n참여자가 수행한 미션이 모아 볼 수 있습니다 🙂"
        case .missionParticipant:
            return "아직 등록된 미션이 없어요.\n관리자가 미션을 등록해주겠죠?! 😉"
        default:
            return ""
        }
    }
}

class EmptyPageView: UIView {
    func setType(type: EmptyPageType) {
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        
        let imageview = UIImageView(image: #imageLiteral(resourceName: "group2").withRenderingMode(.alwaysOriginal), contentMode: .scaleAspectFit).withSize(.init(width: 62, height: 86))
        addSubview(imageview)
        imageview.anchor(.top(topAnchor))
        imageview.centerXToSuperview()
        
        let label = UILabel(text: type.text, font: .systemFont(ofSize: 13), textColor: .lightGray, textAlignment: .center, numberOfLines: 2).withSize(.init(width: 274, height: 40))
        addSubview(label)
        label.anchor(.top(imageview.bottomAnchor, constant: 0))
        label.centerXToSuperview()
        
        centerInSuperview()
        
        withSize(.init(width: 274, height: 102))
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}
