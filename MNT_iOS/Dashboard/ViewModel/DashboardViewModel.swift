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
    var room = UserDefaults.standard.getObject(key: .room) ?? Room()
    private let userFruttoID: Int = UserDefaults.standard.getIntValue(key: .userFruttoId)
    var missionSent: Int = 0
    var missionReceived: Int = 0
    var missionAll: Int = 0
    
    var gridMenu: [DashboardGridMenu] {
        return [
            DashboardGridMenu(image: FruitImage.sharedInstance.getProfileFace(manitto.fruttoId!), subText: "내 푸르또는?", mainText: manitto.name!, type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage2"), subText: "종료일까지", mainText: room.getIntervalDate, type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage3"), subText: "내가 보낸 미션", mainText: "\(missionSent)개/\(missionAll)개", type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage4"), subText: "나에게 온 미션", mainText: "\(missionReceived)개", type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage5"), subText: "방 이름", mainText: room.name, type: .normal),
            DashboardGridMenu(image: #imageLiteral(resourceName: "dashboardImage6"), subText: "알람 설정", type: .togglable, tapAction: { selected in
            })
        ]
    }
    
    var listMenu: [DashboardListMenu] = [
//        DashboardListMenu(image: #imageLiteral(resourceName: "dev"), text: "개발자 정보", action: {
//
//        }),
        DashboardListMenu(image: #imageLiteral(resourceName: "logOut"), text: "방 나가기", action: {
            let alertVC = FruttoAlert2ViewController()
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.setTitleLabel(text: "푸르또 방을 나가시겠습니까?\n한번 나가면 다시 들어올 수 없습니다.")
            alertVC.onConfirm = {
                UserDefaults.standard.deleteAllAboutRoom() {
                    guard let window = UIApplication.shared.windows.first else { return}
                    let coordinator = SceneCoordinator(window: window)
                    let viewModel = MainViewModel(title: "", coordinator: coordinator)
                    let scene = MainScene.main(viewModel as! MainViewModel)
                    coordinator.transition(to: scene, using: .root, animated: true)
                }
            }
            
            UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)
        })
    ]
}

