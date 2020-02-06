//
//  MissionPreviewViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionPreviewViewController: ViewController {
    var viewModel: MissionDetailViewModel?
    
    fileprivate var barButton = UIBarButtonItem(title: "완료",
                                                style: .done,
                                                target: nil,
                                                action: nil)
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let label = UILabel(numberOfLines: 0)
    let fromToView = FromToView()
    
    override func setupLayout() {
        view.stack(
            fromToView.withHeight(80),
            imageView.withHeight(view.bounds.height * 0.4),
            label.withHeight(view.bounds.height * 0.2),
            spacing: 20,
            distribution: .equalSpacing
        )


//        let stackView = UIStackView(arrangedSubviews: [
//            fromToView.withHeight(100),
//            imageView.withHeight(100)
//        ])
//
//        view.addSubview(stackView)
//        stackView.anchor(top: view.topAnchor,
//                         leading: view.leadingAnchor,
//                         bottom: view.bottomAnchor,
//                         trailing: view.trailingAnchor)
//        //stackView.constrainHeight(200)
//        stackView.backgroundColor = .blue
    }
    
    override func setupNavigationController() {
        navigationItem.rightBarButtonItem = barButton
    }
}

extension MissionPreviewViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionDetailViewModel) {
        barButton.rx.action = viewModel.missionCompleteAction()
    }
}
