//
//  ReadyViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//
import Foundation
import RxCocoa
import Action
import RxSwift

class ReadyViewModel: ViewModel {
    func sendKakaoLinkAction() -> CocoaAction {
        return Action { [unowned self] action in
            let room: Room? = UserDefaults.standard.getObject(key: .room)
            let code = room!.id
            
            let template = KMTFeedTemplate { (feedTemplateBuilder) in
                feedTemplateBuilder.content = KMTContentObject(builderBlock: { (contentBuilder) in
                    contentBuilder.title = "프룻프룻프루또\n초대코드 : \(code)"
                    contentBuilder.imageURL = URL(string: "https://frutto-s3-storage.s3.ap-northeast-2.amazonaws.com/%E1%84%8B%E1%85%A1%E1%84%8B%E1%85%B5%E1%84%8F%E1%85%A9%E1%86%AB.png")!
                    contentBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                        linkBuilder.mobileWebURL = URL(string: "https://developers.kakao.com")!
                    })
                })
                
                feedTemplateBuilder.addButton(KMTButtonObject(builderBlock: { (buttonBuilder) in
                    buttonBuilder.title = "앱으로 이동"
                    buttonBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                        linkBuilder.webURL = URL(string: "https://developers.kakao.com")!
                        linkBuilder.mobileWebURL = URL(string: "https://developers.kakao.com")!
                        linkBuilder.iosExecutionParams = "roomnum=\(code)"
                        linkBuilder.androidExecutionParams = "roomnum=\(code)"
                    })
                }))
            }

            // 카카오링크 실행
            KLKTalkLinkCenter.shared().sendDefault(with: template, success: { (warningMsg, argumentMsg) in
                print("warning message: \(String(describing: warningMsg))")
                print("argument message: \(String(describing: argumentMsg))")
            }, failure: { (error) in
                print("error \(error)")
            })
            
            return Observable.just(action)
        }
    }
    
    func enterRoom() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = OpenNittoViewModel(title: "내 푸르또는 누구일까요?", coordinator: self.coordinator)
            let scene: SceneType = MainScene.openNitto(viewModel)
            
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
    
    func presentShowAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = MainUserListViewModel(title: "참여자 리스트", coordinator: self.coordinator)
            let scene: SceneType = MainScene.showParticipant(viewModel)

            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
