//
//  MissionListResponse.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/26.
//  Copyright © 2020 최민섭. All rights reserved.
//
struct OrderMissionResponse: Codable {
    let apiStatus: APIStatus
    var data: [OrderMission] = []
}

struct OrderMission: Codable {
    var id: Int = 0
    var isAbleImg: Int = 0
    var name: String = ""
    var roomId: Int = 0
    var userMissions: [UserMissions] = []
    var countText: String {
        let wholeCount = userMissions.count
        let doneCount = userMissions.filter { $0.userMission.userDone == 1 }.count
        return "\(doneCount)/\(wholeCount)"
    }
}


