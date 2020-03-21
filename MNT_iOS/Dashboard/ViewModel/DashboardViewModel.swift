//
//  DashboardViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

class DashboardViewModel: ViewModel {
    var gridMenu: [DashboardGridMenu] = [
        DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage1"), subText: "내 푸르또는?", mainText: "진유진", type: .normal),
        DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage2"), subText: "종료일까지?", mainText: "D-24", type: .normal),
        DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage3"), subText: "내가 보낸 미션", mainText: "3개/5개", type: .touchable, tapAction: { _ in
            
        }),
        DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage4"), subText: "나에게 온 미션", mainText: "4개", type: .touchable, tapAction: { _ in
            
        }),
        DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage5"), subText: "방 이름", mainText: "넥스터즈 방방방..", type: .normal),
        DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage6"), subText: "알람 설정", type: .togglable, tapAction: { selected in
            
        })
    ]
    
    var listMenu: [DashboardListMenu] = [
        DashboardListMenu(image: #imageLiteral(resourceName: "dev"), text: "개발자 정보", action: {
            
        }),
        DashboardListMenu(image: #imageLiteral(resourceName: "logOut"), text: "방 나가기", action: {
            
        })
    ]
}

