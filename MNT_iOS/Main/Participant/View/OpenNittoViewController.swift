//
//  OpenNittoViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class OpenNittoViewController: ViewController {

    var viewModel: OpenNittoViewModel?
    var mainLabel = UILabel(text: "내 마니또는 누구일까요?", numberOfLines: 0)
    var subLabel = UILabel(text: "나나나님의 마니또는 너너너님입니다.")
    let fromToView = FromToView()
    var descriptionLabel = UILabel(text: "이 날짜까지 마니또 친구들을 많이 많이 챙겨주세요!", numberOfLines: 0)
    let button = PrimaryButton("확인")
    
    var backButton: UIBarButtonItem = {
        let bt = UIBarButtonItem(image: #imageLiteral(resourceName: "close"), style: .plain, target: nil, action: nil)
        bt.tintColor = .defaultText
        return bt
    }()
    
    override func setupLayout() {
        
    }
        
    override func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = backButton
    }
    
}

extension OpenNittoViewController: ViewModelBindableType {
    func bindViewModel(viewModel: OpenNittoViewModel) {
//        fromtoView.manittoLabel.text = viewModel.datas.userId
        //fromtoView.targetLabel.text = viewModel.datas.targetName
    }
}
