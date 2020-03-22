//
//  FruitImage.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/03/22.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FruitImage {
    static let sharedInstance = FruitImage()
    
    private var fruitCircleForIndex: [Int: UIImageView] = [1:UIImageView(image: #imageLiteral(resourceName: "imgProfileTropical")),
                                                           2:UIImageView(image: #imageLiteral(resourceName: "imgProfileAvocado")),
                                                           3:UIImageView(image: #imageLiteral(resourceName: "imgProfileKiwi")),
                                                           4:UIImageView(image: #imageLiteral(resourceName: "imgProfileMelon")),
                                                           5:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatGreenapple")),
                                                           6:UIImageView(image: #imageLiteral(resourceName: "imgProfilePear")),
                                                           7:UIImageView(image: #imageLiteral(resourceName: "imgProfileRedapple")),
                                                           8:UIImageView(image: #imageLiteral(resourceName: "imgProfileWatermelon")),
                                                           9:UIImageView(image: #imageLiteral(resourceName: "imgProfileStrawberry")),
                                                           10:UIImageView(image: #imageLiteral(resourceName: "imgProfilePeach")),
                                                           11:UIImageView(image: #imageLiteral(resourceName: "imgProfileGrape")),
                                                           12:UIImageView(image: #imageLiteral(resourceName: "imgProfileCherry")),
                                                           13:UIImageView(image: #imageLiteral(resourceName: "imgProfileBanana")),
                                                           14:UIImageView(image: #imageLiteral(resourceName: "imgProfileLemon")),
                                                           15:UIImageView(image: #imageLiteral(resourceName: "imgProfilePineapple")),
                                                           16:UIImageView(image: #imageLiteral(resourceName: "imgProfileOrange"))
    ]
    
    private var fruitChatForIndex: [Int: UIImageView] = [1:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatTropical")),
                                                         2:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatAvocado")),
                                                         3:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatKiwi")),
                                                         4:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatPear")),
                                                         5:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatGreenapple")),
                                                         6:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatPear")),
                                                         7:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatRedapple")),
                                                         8:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatWatermelon")),
                                                         9:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatStrawberry")),
                                                         10:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatPeach")),
                                                         11:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatGrape")),
                                                         12:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatCherry")),
                                                         13:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatBanana")),
                                                         14:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatLemon")),
                                                         15:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatPineapple")),
                                                         16:UIImageView(image: #imageLiteral(resourceName: "imgProfileChatOrange"))
    ]
    
    private init() {}
    
    func getFruitCircle(_ index: Int) -> UIImageView {
        return fruitCircleForIndex[index]!
    }
    
    func getFruitChat(_ index: Int) -> UIImageView {
        return fruitChatForIndex[index]!
    }
}
