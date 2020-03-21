//
//  Model.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

struct APIStatus: Codable {
    let label: String
    let httpStatus: Int
}

protocol Model {
    
}

protocol ProducesCellViewModel {
    
}

struct FruttoMission {
    let title, subtitle: String
}

let missionList = [
    // text
    FruttoMission(title: "💬 하고 싶은 이야기", subtitle: "마니또에게 하고 싶은 말을 적어주세요!"),
    FruttoMission(title: "💌 응원의 메시지 보내기", subtitle: "좋은하루가 될 수 있도록 마니또를 응원해주세요."),
    FruttoMission(title: "👏🏻 은근슬쩍 칭찬하기", subtitle: "마니또가 힘이 날 수 있도록 은근슬쩍 칭찬해주세요."),
    FruttoMission(title: "📜 이름으로 3행시 짓기", subtitle: "마니또의 이름으로 3행시를 지어주세요."),
    FruttoMission(title: "🎬 떠오르는 영화 한편", subtitle: "마니또를 보면 어떤 영화가 떠오르나요?"),
    FruttoMission(title: "📰 함께 읽고 싶은 글", subtitle: "마니또와 공유하고 싶은 글을 전달해주세요."),
    FruttoMission(title: "🧞 소원을 말해봐", subtitle: "마니또에게 바라는 소원이 있다면 알려주세요."),
    FruttoMission(title: "🧑‍🤝‍🧑 함께해요", subtitle: "마니또와 함께하고 싶은 것을 적어주세요."),
    FruttoMission(title: "🚑 도움주기", subtitle: "마니또가 알아 채지 못하게 도와주고, 도움을 주었다라고 남겨주세요."),
    FruttoMission(title: "🤔 한 문장으로 힌트주기", subtitle: "내가 더 궁금해지도록, 나에 대한 힌트를 쪼금만 줄까요?"),
    // text & image
    FruttoMission(title: "🕵️ 이미지로 힌트주기", subtitle: "내가 더 궁금해지도록, 나와 관련된 이미지를 전달해주세요."),
    FruttoMission(title: "👀 닮은꼴 캐릭터", subtitle: "마니또와 닮은 캐릭터를 찾아주세요."),
    FruttoMission(title: "⭐ 닮은 연예인 찾기", subtitle: "미담방출! 마니또와 닮은꼴 연예인을 찾아주세요."),
    FruttoMission(title: "🍽️ 어울리는 음식 or 음료", subtitle: "마니또에게 잘 어울리는 음식 or 음료는 무엇인가요?"),
    FruttoMission(title: "🔭 멀리서 관찰하기", subtitle: "마니또가 알아채지 못하게 니또의 모습을 촬영해주세요"),
    FruttoMission(title: "📸 함께 사진찍기", subtitle: "마니또와 함께 찍은 사진을 올려주세요! 들키지 않고 찍어야겠지만, 내 얼굴도 드러나면 안되겠죠?!"),
    FruttoMission(title: "🎁 선물 인증샷", subtitle: "마니또에게 전달할 선물을 사진으로 먼저 알려주세요."),
    FruttoMission(title: "✍️ 마음이 따듯해지는 손편지 ", subtitle: "하고 싶은 말을 적고, 촬영해서 사진으로 보내주세요!")
]
