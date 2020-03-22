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
    let data: Room
}

struct RoomStringResponse: Codable {
    let apiStatus: APIStatus
    let data: String
}

struct RoomUserResponse: Codable {
    let apiStatus: APIStatus
    let data: [Users]
}

struct RoomCheckResponse: Codable {
    let apiStatus: APIStatus
    let data: [RoomCheck] = []
}

struct RoomCheck: Codable {
    let isCreater: Int = 0
    let manitto: Manitto = Manitto()
    let room: Room = Room()
    let user: User = User()
    let userFruttoId: Int? = nil
}

struct Room: Codable, getRoomViewModel {
    let endDay: String = "2020-03-20"
    let id: Int = 0
    let isDone: Int = 0
    let isStart: Int = 0
    let maxPeople: Int = 0
    let name: String = "방이름"
    let startDay: String = "2020-03-20"

    var asRoomViewModel: RoomViewModel {
        return RoomViewModel(datas: self)
    }
}

//struct Room: Codable, getRoomViewModel {
//    let endDay: String
//    let id: Int
//    let isDone: Int
//    let isStart: Int
//    let maxPeople: Int
//    let name: String
//    let startDay: String
//
//    var asRoomViewModel: RoomViewModel {
//        return RoomViewModel(datas: self)
//    }
//}

struct Users : Codable{
    let isCreater: Int
    let manitto: User?
    let user: User?
    let userFruttoId: Int?
}

struct Manitto: Codable {
    let fruttoId: Int? = nil
    let id: String? = nil
    let name: String? = nil
}
