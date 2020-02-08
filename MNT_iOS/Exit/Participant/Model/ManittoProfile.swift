//
//  ManittoProfile.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct ManittoProfile: ProducesProfileCellViewModel {
    let manittoName: String
    let targetName: String
    let manittoImageURL: String
    let targetImageURL: String
    
    var asProfileCellViewModel: ProfileCellViewModel {
        return ProfileCellViewModel(datas: self)
    }
}
