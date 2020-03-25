//
//  SetRoomDetailViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class SetRoomDetailViewModel: ViewModel {
    let maxRelay = BehaviorRelay(value: "")
    let beginDateRelay = BehaviorRelay(value: "")
    let endDateRelay = BehaviorRelay(value: "")
    var roomIdRelay : String = ""
    
    func presentReadyAction() -> CocoaAction {
        return CocoaAction { action in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            let beginDate : Date = dateFormatter.date(from: self.beginDateRelay.value)!
            let endDate : Date = dateFormatter.date(from: self.endDateRelay.value)!
            let minEndDate: Date = beginDate + 86400
            
            if minEndDate > endDate {
                let alert = UIAlertController(title: nil, message: "최소 방 유지 기간은 1일입니다.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                UIApplication.topViewController()?.present(alert, animated: false)

                return Observable.just(action)
            }
            
            if self.beginDateRelay.value == "" || self.endDateRelay.value == "" || self.maxRelay.value == "" {
                let alert = UIAlertController(title: nil, message: "값을 모두 입력해주세요", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                UIApplication.topViewController()?.present(alert, animated: false)
                
                return Observable.just(action)
            }
            else if Int(self.maxRelay.value)! > 15 {
                let alert = UIAlertController(title: nil, message: "인원 수를 15명 이하로 입력해주세요", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                UIApplication.topViewController()?.present(alert, animated: false)
                
                return Observable.just(action)
            }
            else {
                self.makeRoom()
                
                let viewModel = ReadyViewModel(title: "대기화면", coordinator: self.coordinator)
                let scene = MainScene.ready(viewModel)
                return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
            }
        }
    }
    
    func makeRoom() {
        print("fisrt")
        APISource.shared.postRoomMake(room: Room(endDay: "2020-03-25",
                                                 id: 0,
                                                 isDone: 0,
                                                 isStart: 0,
                                                 maxPeople: 4,
                                                 name: "wowwow",
                                                 startDay: "2020-03-25"),
                                      userId: "rmt") { (roomId) in
                                        print("fourth")
                                        print("roomId : \(roomId)")
        }?.disposed(by: rx.disposeBag)
    }
}


