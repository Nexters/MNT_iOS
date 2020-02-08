//
//  MissionCellViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

protocol ProducesMissionCellViewModel {
    var asMissionCellViewModel: MissionCellViewModel { get }
}

class MissionCellViewModel {    
    let datas: Mission
    
    init(datas: Mission) {
        self.datas = datas
    }
}
