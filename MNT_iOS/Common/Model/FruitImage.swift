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
    
    private var fruitCircleForIndex: [Int: UIImage] = [1:UIImage(#imageLiteral(resourceName: "imgProfileTropical")),
                                                       2:UIImage(#imageLiteral(resourceName: "imgProfileAvocado")),
                                                       3:UIImage(#imageLiteral(resourceName: "imgProfileKiwi")),
                                                       4:UIImage(#imageLiteral(resourceName: "imgProfileMelon")),
                                                       5:UIImage(#imageLiteral(resourceName: "imgProfileGreenapple")),
                                                       6:UIImage(#imageLiteral(resourceName: "imgProfilePear")),
                                                       7:UIImage(#imageLiteral(resourceName: "imgProfileRedapple")),
                                                       8:UIImage(#imageLiteral(resourceName: "imgProfileWatermelon")),
                                                       9:UIImage(#imageLiteral(resourceName: "imgProfileStrawberry")),
                                                       10:UIImage(#imageLiteral(resourceName: "imgProfilePeach")),
                                                       11:UIImage(#imageLiteral(resourceName: "imgProfileGrape")),
                                                       12:UIImage(#imageLiteral(resourceName: "imgProfileCherry")),
                                                       13:UIImage(#imageLiteral(resourceName: "imgProfileBanana")),
                                                       14:UIImage(#imageLiteral(resourceName: "imgProfileLemon")),
                                                       15:UIImage(#imageLiteral(resourceName: "imgProfilePineapple")),
                                                       16:UIImage(#imageLiteral(resourceName: "imgProfileOrange"))
    ]
    
    private var fruitChatForIndex: [Int: UIImage] = [1:UIImage(#imageLiteral(resourceName: "imgProfileChatTropical")),
                                                     2:UIImage(#imageLiteral(resourceName: "profileChatAvocado")),
                                                     3:UIImage(#imageLiteral(resourceName: "imgProfileChatKiwi")),
                                                     4:UIImage(#imageLiteral(resourceName: "imgProfileChatPear")),
                                                     5:UIImage(#imageLiteral(resourceName: "imgProfileChatGreenapple")),
                                                     6:UIImage(#imageLiteral(resourceName: "imgProfileChatPear")),
                                                     7:UIImage(#imageLiteral(resourceName: "imgProfileChatRedapple")),
                                                     8:UIImage(#imageLiteral(resourceName: "imgProfileChatWatermelon")),
                                                     9:UIImage(#imageLiteral(resourceName: "imgProfileChatStrawberry")),
                                                     10:UIImage(#imageLiteral(resourceName: "imgProfileChatPeach")),
                                                     11:UIImage(#imageLiteral(resourceName: "imgProfileChatGrape")),
                                                     12:UIImage(#imageLiteral(resourceName: "imgProfileChatCherry")),
                                                     13:UIImage(#imageLiteral(resourceName: "imgProfileChatBanana")),
                                                     14:UIImage(#imageLiteral(resourceName: "imgProfileChatLemon")),
                                                     15:UIImage(#imageLiteral(resourceName: "imgProfileChatPineapple")),
                                                     16:UIImage(#imageLiteral(resourceName: "imgProfileChatOrange"))
    ]
    
    private var fruitNameForIndex: [Int: String] = [
        1: "관리자",
        2: "보카도",
        3: "키위링",
        4: "말론",
        5: "그린애플",
        6: "배에",
        7: "레드애플",
        8: "워터말론",
        9: "베리",
        10: "숭아",
        11: "포도링",
        12: "체리또",
        13: "나나",
        14: "레모니",
        15: "파이리",
        16: "오랑지"
    ]
    
    private var fruitForIndex: [Int: UIImage] = [1:UIImage(#imageLiteral(resourceName: "imgProfileIconTropical")),
                                                 2:UIImage(#imageLiteral(resourceName: "imgProfileIconAvocado")),
                                                 3:UIImage(#imageLiteral(resourceName: "imgProfileIconKiwi")),
                                                 4:UIImage(#imageLiteral(resourceName: "imgProfileIconMelon")),
                                                 5:UIImage(#imageLiteral(resourceName: "imgProfileIconGreenapple")),
                                                 6:UIImage(#imageLiteral(resourceName: "imgProfileIconPear")),
                                                 7:UIImage(#imageLiteral(resourceName: "imgProfileIconRedapple")),
                                                 8:UIImage(#imageLiteral(resourceName: "imgProfileIconWatermelon")),
                                                 9:UIImage(#imageLiteral(resourceName: "imgProfileIconStrawberry")),
                                                 10:UIImage(#imageLiteral(resourceName: "imgProfileIconPeach")),
                                                 11:UIImage(#imageLiteral(resourceName: "imgProfileIconGrape")),
                                                 12:UIImage(#imageLiteral(resourceName: "imgProfileIconCherry")),
                                                 13:UIImage(#imageLiteral(resourceName: "imgProfileIconBanana")),
                                                 14:UIImage(#imageLiteral(resourceName: "imgProfileIconLemon")),
                                                 15:UIImage(#imageLiteral(resourceName: "imgProfileIconPineapple")),
                                                 16:UIImage(#imageLiteral(resourceName: "imgProfileIconOrange"))
    ]
    
    private var fruitPopUpForIndex: [Int: UIImage] = [2:UIImage(#imageLiteral(resourceName: "imgPopupEndAvocado")),
                                                      3:UIImage(#imageLiteral(resourceName: "imgPopupEndKiwi")),
                                                      4:UIImage(#imageLiteral(resourceName: "imgPopupEndMelon")),
                                                      5:UIImage(#imageLiteral(resourceName: "imgPopupEndGreenapple")),
                                                      6:UIImage(#imageLiteral(resourceName: "imgPopupEndPear")),
                                                      7:UIImage(#imageLiteral(resourceName: "imgPopupEndRedapple")),
                                                      8:UIImage(#imageLiteral(resourceName: "imgPopupEndWatermelon")),
                                                      9:UIImage(#imageLiteral(resourceName: "imgPopupEndStrawberry")),
                                                      10:UIImage(#imageLiteral(resourceName: "imgPopupEndPeach")),
                                                      11:UIImage(#imageLiteral(resourceName: "imgPopupEndGrape")),
                                                      12:UIImage(#imageLiteral(resourceName: "endCherry")),
                                                      13:UIImage(#imageLiteral(resourceName: "imgPopupEndBanana")),
                                                      14:UIImage(#imageLiteral(resourceName: "imgPopupEndLemon")),
                                                      15:UIImage(#imageLiteral(resourceName: "imgPopupEndPineapple")),
                                                      16:UIImage(#imageLiteral(resourceName: "imgPopupEndOrange"))
    ]
    
    private var profileFaceForIndex: [Int: UIImage] = [1:UIImage(named: "imgProfileFace01")!,
                                                       2:UIImage(named: "imgProfileFace02")!,
                                                       3:UIImage(named: "imgProfileFace03")!,
                                                       4:UIImage(named: "imgProfileFace04")!,
                                                       5:UIImage(named: "imgProfileFace05")!,
                                                       6:UIImage(named: "imgProfileFace06")!,
                                                       7:UIImage(named: "imgProfileFace07")!,
                                                       8:UIImage(named: "imgProfileFace08")!,
                                                       9:UIImage(named: "imgProfileFace09")!,
                                                       10:UIImage(named: "imgProfileFace10")!,
                                                       11:UIImage(named: "imgProfileFace11")!,
                                                       12:UIImage(named: "imgProfileFace12")!,
                                                       13:UIImage(named: "imgProfileFace13")!,
                                                       14:UIImage(named: "imgProfileFace14")!,
                                                       15:UIImage(named: "imgProfileFace15")!
    ]
    
    
    
    private init() {}
    
    func getFruitCircle(_ index: Int) -> UIImage {
        return fruitCircleForIndex[index+1]!
    }
    
    func getFruitChat(_ index: Int) -> UIImage {
        return fruitChatForIndex[index+1]!
    }
    
    func getFruit(_ index: Int) -> UIImage {
        return fruitForIndex[index+1]!
    }
    
    func getFruitPopUp(_ index: Int) -> UIImage {
        return fruitPopUpForIndex[index]!
    }
    
    func getProfileFace(_ index: Int) -> UIImage {
        return profileFaceForIndex[index+1]!
    }

    func getFruitName(_ index: Int) -> String {
        return fruitNameForIndex[index+1]!
    }
}
