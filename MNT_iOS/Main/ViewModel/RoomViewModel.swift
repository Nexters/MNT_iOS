//
//  RoomViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/01.
//  Copyright © 2020 최민섭. All rights reserved.
//

protocol getRoomViewModel {
    var asRoomViewModel: RoomViewModel { get }
}

class RoomViewModel {
    let datas: Room
    init(datas: Room) {
        self.datas = datas
    }
}
