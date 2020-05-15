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
            let code = 11111
            
            let template = KMTTextTemplate { (textTemplateBuilder) in
                textTemplateBuilder.text = "마니또를 생성하였습니다."
                textTemplateBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                    //linkBuilder.webURL = URL(string: url)!
                    //linkBuilder.mobileWebURL = URL(string: "https://developers.kakao.com")!
                    linkBuilder.iosExecutionParams = "\(code)"
                    linkBuilder.androidExecutionParams = "\(code)"
                })
                textTemplateBuilder.buttonTitle = "앱에서 보기"
            }

            // 카카오링크 실행
            KLKTalkLinkCenter.shared().sendDefault(with: template, success: { (warningMsg, argumentMsg) in
                // 성공
                print("warning message: \(String(describing: warningMsg))")
                print("argument message: \(String(describing: argumentMsg))")
            }, failure: { (error) in
                // 실패
                //self.alert(error.localizedDescription)
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
