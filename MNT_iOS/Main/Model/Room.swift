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
    let data: [RoomCheck]?
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
    var endDay: String = ""
    var id: Int = 83550
    var isDone: Int = 0
    var isStart: Int = 0
    var maxPeople: Int = 0
    var name: String = ""
    var startDay: String = ""

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
