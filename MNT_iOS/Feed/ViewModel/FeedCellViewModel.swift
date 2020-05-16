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
        return imageInstance.getFruitChat(datas.userFruttoId+1)
    }
    var targetImage: UIImage? {
        return imageInstance.getProfileFace(datas.manittoFruttoId)
    }
    var postURL: URL? {
        return URL(string: datas.missionImg)
    }
    var contentTitle: String {
        // TODO: 앞에꺼 잘라야함.
        return datas.contentTitle
    }
    var content: String {
        return datas.content
    }
    var fromToLabel: String {
        return "\(imageInstance.getFruitName(datas.userFruttoId+1))님이 \(datas.manittoName)에게 "
    }
    var date: String {
        return datas.userDoneTime
    }
}
