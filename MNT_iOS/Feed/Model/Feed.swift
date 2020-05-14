//
//  FeedModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct FeedResponse: Codable {
    let apiStatus: APIStatus
    let data: [Feed]
}

struct Feed: Codable, ProducesFeedCellViewModel {
    let id: Int
    let content: String
    let missionId: MissionId?
    let missionImg: String
    let roodId: Int
    let userDone: Int
    let userDoneTime: String
    let userId: String
    
    /// added
    let userFruttoId: Int
    let userName: String
    let manittoId: String
    let manittoFruttoId: Int
    let manittoName: String
    
    var asFeedCellViewModel: FeedCellViewModel {
        return FeedCellViewModel(datas: self)
    }
}
