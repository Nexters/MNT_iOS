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
    var data: [Mission] = []
}

struct Mission: Codable, ProducesMissionCellViewModel {
    var id: Int = 0
    var content: String = ""
    var missionId: MissionId = MissionId()
    var missionImg: String = ""
    var roodId: Int = 0
    var userDone: Int = 0
    var userDoneTime: String = ""
    var userId: String = ""
    
    var asMissionCellViewModel: MissionCellViewModel { return MissionCellViewModel(datas: self)}
}

struct MissionId: Codable {
    var id: Int = 0
    var isAbleImg: Int = 0
    var name: String = ""
    var roodId: Int = 0
    var userMissions: [UserMissions] = []
}

struct UserMissions: Codable {
    
}
