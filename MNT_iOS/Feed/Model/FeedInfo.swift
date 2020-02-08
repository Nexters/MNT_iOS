//
//  FeedModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct FeedInfo: ProducesFeedCellViewModel {
    
    let manittoName: String
    let manittoProfileImageURL: String
    let targetName: String
    let targetProfileImageURL: String
    let postURL: String
    let text: String
    
    var asFeedCellViewModel: FeedCellViewModel {
        return FeedCellViewModel(datas: self)
    }
}
