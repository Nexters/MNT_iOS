//
//  EmptyPage.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/05/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

enum EmptyPageType {
    case feed
}

extension EmptyPageType {
    var text: String {
        switch self {
        case .feed:
            return "미션을 등록해주세요!\n참여자가 수행한 미션이 모아 볼 수 있습니다 🙂"
        default:
            return ""
        }
    }
}

class EmptyPageView: UIView {
    init(type: EmptyPageType) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        stack(
            UIImageView(image: #imageLiteral(resourceName: "group2")).withSize(.init(width: 42, height: 46)),
            UILabel(text: type.text, font: .systemFont(ofSize: 13), textColor: .lightGray, textAlignment: .center, numberOfLines: 2),
            spacing: 16
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
