//
//  UserListResponse.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct UserListResponse: Codable {
    let apiStatus: APIStatus
    var data: [Participant] = []
}

struct Participant: Codable {
    var id: Int = 0
    var room: RoomInfo = RoomInfo()
    var user: User = User()
    var manittoId: String? = nil
    var isCreater: Int = 0
}

struct User: Codable {
    var id: String = ""
    var name: String = ""
    var profilePic: String = ""
    var fcmToken: String = ""
}

struct RoomInfo: Codable {
    var id: Int = 0
    var name: String = ""
    var maxPeople: Int = 0
    var endDay: String = ""
    var startDay: String = ""
    var isDone: Int = 0
    var isStart: Int = 0
}