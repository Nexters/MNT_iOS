//
//  Room.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/16.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct RoomAttendResponse: Codable {
    let apiStatus: APIStatus
    let data: Room = Room()
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
