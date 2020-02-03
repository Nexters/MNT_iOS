//
//  SendMission.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct SendMission {
    let mission: Mission
    let fromId, toId: Int
    let fromImageURL, toImageURL: String
    let text: String
    let imageURL: String
}
