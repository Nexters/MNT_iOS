//
//  ReadyViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class ReadyViewController: ViewController {
    
    var viewModel: ReadyViewModel?
    let titleLabel = UILabel(text: "title", numberOfLines: 0)
    let codeLabel = UILabel(text: "초대코드", numberOfLines: 0)
    let descriptionLabel = UILabel(text: "마니또 방이 생성되었습니다.\n 초대코드를 공유해서 친구들을 초대하세요.")
    var sendButton = UIButton(title: "카카오톡 초대장 보내기", titleColor: .black)
    var checkButton = UIButton(title: "참여자 확인", titleColor: .black)
    var startButton = UIButton(title: "시작하기", titleColor: .black)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }
    
    override func setupLayout() {
        view.stack(titleLabel.withHeight(50),
                   codeLabel.withHeight(50),
                   descriptionLabel.withHeight(50),
                   sendButton.withHeight(50),
                   checkButton.withHeight(50),
                   startButton.withHeight(50),
                   alignment: .center,
                   distribution: .fillEqually
)
            .withMargins(.init(top: view.frame.height/2 - 300,
                               left: 0,
                               bottom: view.frame.height/2 - 300,
                               right: 0))
    }

}

extension ReadyViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        var dummyCode: Int = 11111
        
        sendButton.rx.action = viewModel.sendKakaoLinkAction(code : dummyCode)
    }
}
