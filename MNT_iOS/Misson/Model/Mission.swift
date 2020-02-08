//
//  Mission.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct Mission: ProducesMissionCellViewModel {
    let id: Int
    let title: String
    let subTitle: String
    var isDone: Bool
    
    var asMissionCellViewModel: MissionCellViewModel { return MissionCellViewModel(datas: self)}
}
