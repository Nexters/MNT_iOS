//
//  Mission.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct MissionListResponse: Codable {
    let apiStatus: APIStatus
    let data: [Mission]
}

struct Mission: Codable, ProducesMissionCellViewModel {
    let id: Int
    let content: String
    let missionId: MissionId?
    let missionImg: String
    let roodId: Int
    let userDone: Int
    let userDoneTime: String
    let userId: String
    
    var asMissionCellViewModel: MissionCellViewModel { return MissionCellViewModel(datas: self)}
}

struct MissionId: Codable {
    let id: Int
    let isAbleImg: Int
    let name: String
    let roodId: Int
    let userMissions: [UserMissions]
}

struct UserMissions: Codable {
    
}
