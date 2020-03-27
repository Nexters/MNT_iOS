//
//  MissionCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
class MissionCell: UITableViewCell {
    fileprivate let label = UILabel(font: .boldSystemFont(ofSize: 15), numberOfLines: 1)
    fileprivate let view = MissionCellButtonForParitipant()
    fileprivate let countLabel = UILabel(font: .systemFont(ofSize: 13), textColor: .accentColor)

    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let inset: CGFloat = 26
            var frame = newFrame
            frame.origin.x += inset
            frame.origin.y += 5
            frame.size.width -= 2 * inset
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(view)
        addSubview(label)
        addSubview(countLabel)
        
        view.centerYToSuperview()
        view.anchor(.trailing(trailingAnchor, constant: 16))
        
        label.centerYToSuperview()
        label.anchor(.leading(leadingAnchor, constant: 24))
        let constraint = label.trailingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 15)
        constraint.priority = .defaultLow
        constraint.isActive = true
        
        selectedBackgroundView = .init(backgroundColor: .clear)
        
        countLabel.centerYToSuperview()
        countLabel.anchor(.trailing(trailingAnchor, constant: 16))
    }
}

extension MissionCell {
    func setup<T>(mission: T) {
        if let mission: Mission = mission as? Mission {
            // check is done or not
            if mission.userMission.userDone != 1 {
                view.setupState(state: .yet)
                label.alpha = 1
                view.alpha = 1
                backgroundColor = .white
                setupShadow(opacity: 0.07, radius: 10, offset: .init(width: 0, height: 1))
                alpha = 1
            } else {
                view.setupState(state: .done)
                //backgroundColor = .defaultShadow
                label.alpha = 0.4
                view.alpha = 0.4
                backgroundColor = UIColor.grayColor.withAlphaComponent(0.3)
                setupShadow(radius: 10, color: .clear)
            }
            
            label.text = mission.missionName
        }
        
        if let orderMission: OrderMission = mission as? OrderMission {
            label.text = orderMission.name
            label.alpha = 1
            view.isHidden = true
            countLabel.text = orderMission.countText
            backgroundColor = .white
            setupShadow(opacity: 0.07, radius: 10, offset: .init(width: 0, height: 1))
            alpha = 1
        }
    }
}

class MissionCellButtonForParitipant: UIView {
    
    public enum MissionState {
        case done
        case yet
    }
    
    let imageview = UIImageView(image: #imageLiteral(resourceName: "arrowRight"))
    let textLabel = UILabel(text: nil, font: .boldSystemFont(ofSize: 12), textColor: .accentText)
     
    public func setupState(state: MissionState) {
        switch state {
        case .done:
            textLabel.text = "수행완료"
            textLabel.textColor = .black
            imageview.image = #imageLiteral(resourceName: "check")
            imageview.tintColor = .black
        case .yet:
            textLabel.text = "수행하기"
            textLabel.textColor = .accentText
            imageview.image = #imageLiteral(resourceName: "arrowRight")
            imageview.tintColor = .accentText
        }
        
        hstack(textLabel, imageview, spacing: 3)
    }
}

class MissionCellButtonForAdimistrator: UIView {
    let numberOfDone: Int
    init(numberOfDone: Int) {
        self.numberOfDone = numberOfDone
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
