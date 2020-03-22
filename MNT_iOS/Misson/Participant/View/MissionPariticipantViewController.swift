//
//  MissionViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MissionParticipantViewController: ViewController {
    
    var viewModel: MissionViewModel?
    let missionTableController = MissionTableViewController()

    override func setupLayout() {
        view.addSubview(missionTableController.view)
        missionTableController.view.fillSuperview()
    }
}

extension MissionParticipantViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionViewModel) {
         
        // setupDummys
//        (0...6).forEach { viewModel.missions.append(Mission(id: $0,
//                                                            text: "메시지 보내기",
//                                                            missionName: "부제목이지롱",
//                                                            isDone: $0 % 2 == 0)) }
        

        getTimeline()
    }
    
    private func getTimeline() {
//        APISource.shared.getTimeline(roomId: 0) { (missions) in
//            print(missions)
//            }?.disposed(by: rx.disposeBag)
        
        (0...7).forEach{ [unowned self] i in
            self.viewModel?.missions.append(Mission(id: 1,
                                                    content: String(i),
                                                    missionId: nil,
                                                    missionImg: "https://img.huffingtonpost.com/asset/5c6a1b8a250000be00c88cae.png?cache=41JoK4KsMg&ops=scalefit_630_noupscale",
                                                    roodId: 1,
                                                    userDone: 0,
                                                    userDoneTime: "12:30",
                                                    userId: "its me"))
        }
        missionTableController.viewModel = self.viewModel
    }
}
