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
    var room: Room = Room(endDay: "", id: 0, isDone: 0, isStart: 0, maxPeople: 0, name: "", startDay: "")
    var user: User 
    var manittoId: String? = nil
    var isCreater: Int = 0
}

struct User: Codable {
    var id: String = ""
    var name: String = ""
    var profilePic: String = ""
    var fcmToken: String  = ""
}
