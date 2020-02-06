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
    func sendKakaoLinkAction(code: Int) -> CocoaAction {
        return Action { [unowned self] action in
            let template = KMTFeedTemplate { (feedTemplateBuilder) in
                feedTemplateBuilder.content = KMTContentObject(builderBlock: { (contentBuilder) in
                    contentBuilder.title = "프룻프룻프루또\n초대코드 : \(code)"
                    contentBuilder.imageURL = URL(string: "http://mud-kage.kakao.co.kr/dn/NTmhS/btqfEUdFAUf/FjKzkZsnoeE4o19klTOVI1/openlink_640x640s.jpg")!
                    contentBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                        linkBuilder.mobileWebURL = URL(string: "https://developers.kakao.com")!
                    })
                })
            
                feedTemplateBuilder.addButton(KMTButtonObject(builderBlock: { (buttonBuilder) in
                    buttonBuilder.title = "앱으로 이동"
                    buttonBuilder.link = KMTLinkObject(builderBlock: { (linkBuilder) in
                        //linkBuilder.webURL = URL(string: url)!
                        //linkBuilder.mobileWebURL = URL(string: "https://developers.kakao.com")!
                        linkBuilder.iosExecutionParams = "code=\(code)"
                        linkBuilder.androidExecutionParams = "code=\(code)"
                    })
                }))
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
}
