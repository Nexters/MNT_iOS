//
//  Mission.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

//{
//  "apiStatus": "ApiStatus.Ok(label=Success, httpStatus=200)",
//  "data": [
//    {
//      "content": "string",
//      "id": 0,
//      "missionId": {
//        "id": 0,
//        "isAbleImg": 0,
//        "name": "string",
//        "roomId": 0,
//        "userMissions": [
//          {}
//        ]
//      },
//      "missionImg": "string",
//      "roomId": 0,
//      "userDone": 0,
//      "userDoneTime": "2020-02-10",
//      "userId": "string"
//    }
//  ]
//}
struct MissionListResponse: Codable {
    let apiStatus: APIStatus
    let data: [Mission]
}

struct Mission: Codable, ProducesMissionCellViewModel {
    let id: Int
    let content: String
    let missionId: MissionId
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
