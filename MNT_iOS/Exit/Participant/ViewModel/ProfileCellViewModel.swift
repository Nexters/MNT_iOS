//
//  ProfileCellViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

protocol ProducesProfileCellViewModel {
    var asProfileCellViewModel: ProfileCellViewModel { get }
}

class ProfileCellViewModel {
    let datas: ManittoProfile
    init(datas: ManittoProfile) {
        self.datas = datas
    }
    
    var manittoImageURL: URL? {
        return URL(string: datas.manittoImageURL)
    }
    var targetImageURL: URL? {
        return URL(string: datas.targetImageURL)
    }
}
