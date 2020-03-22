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

struct Room: Codable, getRoomViewModel {
    let endDay: String
    let id: Int
    let isDone: Int
    let isStart: Int
    let maxPeople: Int
    let name: String
    let startDay: String

    var asRoomViewModel: RoomViewModel {
        return RoomViewModel(datas: self)
    }
}

//struct Room: Codable, getRoomViewModel {
//    let endDay: String = "2020-03-18"
//    let id: Int = 0
//    let isDone: Int = 0
//    let isStart: Int = 0
//    let maxPeople: Int = 0
//    let name: String = "onp"
//    let startDay: String = "2020-03-18"
//
//    var asRoomViewModel: RoomViewModel {
//        return RoomViewModel(datas: self)
//    }
//}

struct Users : Codable{
    let isCreater: Int
    let manitto: User?
    let user: User?
    let userFruttoId: Int
}
