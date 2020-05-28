//
//  DashboardViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

class DashboardViewModel: ViewModel {
    let user: User = UserDefaults.standard.getObject(key: .user) ?? User()
    private let manitto: Manitto = UserDefaults.standard.getObject(key: .manitto) ?? Manitto()
    var room = Room()
    private let userFruttoID: Int = UserDefaults.standard.getIntValue(key: .userFruttoId)
    var missionSent: Int = 0
    var missionReceived: Int = 0
    var missionAll: Int = 0
    
    
    var gridMenu: [DashboardGridMenu] {
        return [
            DashboardGridMenu(image: FruitImage.sharedInstance.getProfileFace(manitto.fruttoId! + 1), subText: "내 푸르또는?", mainText: manitto.name!, type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage2"), subText: "종료일?", mainText: room.endDay, type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage3"), subText: "내가 보낸 미션", mainText: "\(missionSent)개/\(missionAll)개", type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage4"), subText: "나에게 온 미션", mainText: "\(missionReceived)개", type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage5"), subText: "방 이름", mainText: room.name, type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage6"), subText: "알람 설정", type: .togglable, tapAction: { selected in
                
            })
        ]
    }
    
    var listMenu: [DashboardListMenu] = [
        DashboardListMenu(image: #imageLiteral(resourceName: "dev"), text: "개발자 정보", action: {
            
        }),
        DashboardListMenu(image: #imageLiteral(resourceName: "logOut"), text: "방 나가기", action: {
            
        })
    ]
}

