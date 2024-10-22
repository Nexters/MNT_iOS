//
//  FeedCellViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

protocol ProducesFeedCellViewModel {
    var asFeedCellViewModel: FeedCellViewModel { get }
}

class FeedCellViewModel {
    let datas: Feed
    let imageInstance = FruitImage.sharedInstance
    init(datas: Feed) {
        self.datas = datas
    }
    
    var manittoImage: UIImage? {
        return imageInstance.getFruitChat(datas.userFruttoId)
    }
    var targetImage: UIImage? {
        return imageInstance.getProfileFace(datas.manittoFruttoId)
    }
    var postURL: URL? {
        return URL(string: datas.missionImg)
    }
    var contentTitle: String {
        // TODO: 앞에꺼 잘라야함.
        let str = datas.contentTitle
        let start = str.index(after: str.startIndex)
        let end = str.index(before: str.endIndex)
        let substring = str[start...end]
        return "#" + String(substring)
    }
    var content: String {
        return datas.content
    }
    var fromToLabel: String {
        var username = imageInstance.getFruitName(datas.userFruttoId)
        
        if UserDefaults.standard.getIntValue(key: .isOver) == 1 {
            username = datas.userName
        }
        
        return "\(username)님이 \(datas.manittoName)에게 "
    }
    var date: String {
        return datas.userDoneTime.timeFormatted()
    }
}
