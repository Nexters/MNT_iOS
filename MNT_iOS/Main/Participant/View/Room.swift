//
//  Room.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct RoomAttendResponse: Codable {
    let apiStatus: APIStatus
    let data: [Room]
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
