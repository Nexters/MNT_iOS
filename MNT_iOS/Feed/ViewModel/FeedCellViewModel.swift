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
    init(datas: Feed) {
        self.datas = datas
    }
    
    var manittoImageURL: URL? {
        return URL(string: "")
    }
    var targetImageURL: URL? {
        return URL(string: "")
    }
    var postURL: URL? {
        return URL(string: datas.missionImg)
    }
}
