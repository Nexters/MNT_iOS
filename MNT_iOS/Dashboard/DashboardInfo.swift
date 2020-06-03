//
//  DashboardInfo.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/05/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct DashboardResponse: Codable {
    let data: DashboardInfo
    let apiStatus: APIStatus
}

struct DashboardInfo: Codable {
    var missionCountOfAll: Int? = 0
    var missionCountOfUserSend: Int? = 0
    var missionCountOfUserReceive: Int? = 0
    var room: Room? = Room()
}
