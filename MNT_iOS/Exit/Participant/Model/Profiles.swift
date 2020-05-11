//
//  Profiles.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/05/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct Profiles: ProducesProfileCellViewModel{
    let name: String
    let ImageURL: String
    
    var asProfileCellViewModel: ProfileCellViewModel {
         return ProfileCellViewModel(datas: self)
    }
}
