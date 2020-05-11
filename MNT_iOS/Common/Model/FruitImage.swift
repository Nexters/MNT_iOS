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
    
    private var fruitForIndex: [Int: UIImageView] = [1:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconTropical")),
                                                     2:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconAvocado")),
                                                     3:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconKiwi")),
                                                     4:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconMelon")),
                                                     5:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconGreenapple")),
                                                     6:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconPear")),
                                                     7:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconRedapple")),
                                                     8:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconWatermelon")),
                                                     9:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconStrawberry")),
                                                     10:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconPeach")),
                                                     11:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconGrape")),
                                                     12:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconCherry")),
                                                     13:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconBanana")),
                                                     14:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconLemon")),
                                                     15:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconPineapple")),
                                                     16:UIImageView(image: #imageLiteral(resourceName: "imgProfileIconOrange"))
    ]
    
    private var fruitPopUpForIndex: [Int: UIImageView] = [2:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndAvocado")),
                                                  3:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndKiwi")),
                                                  4:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndMelon")),
                                                  5:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndGreenapple")),
                                                  6:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndPear")),
                                                  7:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndRedapple")),
                                                  8:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndWatermelon")),
                                                  9:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndStrawberry")),
                                                  10:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndPeach")),
                                                  11:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndGrape")),
                                                  12:UIImageView(image: #imageLiteral(resourceName: "endCherry")),
                                                  13:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndBanana")),
                                                  14:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndLemon")),
                                                  15:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndPineapple")),
                                                  16:UIImageView(image: #imageLiteral(resourceName: "imgPopupEndOrange"))
    ]
    
//    private var profileFaceForIndex: [Int: UIImageView] = [2:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace01")),
//                                                  3:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace02")),
//                                                  4:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace03")),
//                                                  5:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace04")),
//                                                  6:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace05")),
//                                                  7:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace06")),
//                                                  8:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace07")),
//                                                  9:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace08")),
//                                                  10:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace09")),
//                                                  11:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace10")),
//                                                  12:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace11")),
//                                                  13:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace12")),
//                                                  14:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace13")),
//                                                  15:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace14")),
//                                                  16:UIImageView(image: #imageLiteral(resourceName: "imgProfileFace15"))
//    ]
    
    private var profileFaceForIndex: [Int: UIImage] = [2:UIImage(named: "imgProfileFace01")!,
                                                       3:UIImage(named: "imgProfileFace02")!,
                                                       4:UIImage(named: "imgProfileFace03")!,
                                                       5:UIImage(named: "imgProfileFace04")!,
                                                       6:UIImage(named: "imgProfileFace05")!,
                                                       7:UIImage(named: "imgProfileFace06")!,
                                                       8:UIImage(named: "imgProfileFace07")!,
                                                       9:UIImage(named: "imgProfileFace08")!,
                                                       10:UIImage(named: "imgProfileFace09")!,
                                                       11:UIImage(named: "imgProfileFace10")!,
                                                       12:UIImage(named: "imgProfileFace11")!,
                                                       13:UIImage(named: "imgProfileFace12")!,
                                                       14:UIImage(named: "imgProfileFace13")!,
                                                       15:UIImage(named: "imgProfileFace14")!,
                                                       16:UIImage(named: "imgProfileFace15")!
    ]
    
    private init() {}
    
    func getFruitCircle(_ index: Int) -> UIImageView {
        return fruitCircleForIndex[index]!
    }
    
    func getFruitChat(_ index: Int) -> UIImageView {
        return fruitChatForIndex[index]!
    }
    
    func getFruit(_ index: Int) -> UIImageView {
        return fruitForIndex[index]!
    }
    
    func getFruitPopUp(_ index: Int) -> UIImageView {
        return fruitPopUpForIndex[index]!
    }
    
//    func getProfileFace(_ index: Int) -> UIImageView {
//        return profileFaceForIndex[index]!
//    }
    
    func getProfileFace(_ index: Int) -> UIImage {
        return profileFaceForIndex[index]!
    }
}
