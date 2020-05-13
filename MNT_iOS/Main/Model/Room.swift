//
//  Room.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/16.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct RoomResponse: Codable {
    let apiStatus: APIStatus
    let data: Room?
}

struct RoomStringResponseTest: Codable {
    let apiStatus: APIStatus
    let data: String
}

struct RoomStringResponse: Codable {
    let apiStatus: APIStatus
    let data: String?
}

struct RoomUserResponse: Codable {
    let apiStatus: APIStatus
    let data: [Users]
}

struct RoomCheckResponse: Codable {
    let apiStatus: APIStatus
    let data: [RoomCheck]
}

struct ManittoResponse: Codable {
    let apiStatus: APIStatus
    let data: Manitto
}

struct RoomCheck: Codable {
    let isCreater: Int
    let manitto: Manitto
    let room: Room
    let user: User
    let userFruttoId: Int?
}

struct Room: Codable, getRoomViewModel {
    let endDay: String = ""
    let id: Int = 0
    let isDone: Int = 0
    let isStart: Int = 0
    let maxPeople: Int = 0
    let name: String = ""
    let startDay: String = ""

    var asRoomViewModel: RoomViewModel {
        return RoomViewModel(datas: self)
    }
}

struct Users : Codable{
    let isCreater: Int
    let manitto: User?
    let user: User?
    let userFruttoId: Int?
}
