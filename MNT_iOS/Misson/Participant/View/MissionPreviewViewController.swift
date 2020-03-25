//
//  MissionPreviewViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionPreviewViewController: ViewController {
    var viewModel: MissionPreviewViewModel?
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "profileFace01"), contentMode: .scaleAspectFill)
    let titleLabel = UILabel(font: .boldSystemFont(ofSize: 15), numberOfLines: 1)
    let label = UILabel(numberOfLines: 0)
    let fromToView = FromToView()
    fileprivate lazy var button: PrimaryButton = {
        let b = PrimaryButton("완료")
        return b
    }()
    
    override func setupLayout() {
        view.addSubview(button)
        button.anchor(.bottom(bottomAnchor))
        button.centerXToSuperview()
        
//        view.addSubview(fromToView)
//        view.addSubview(imageView)
//        view.addSubview(titleLabel)
//        view.addSubview(label)
//
//        fromToView.anchor(.top(topAnchor, constant: 15), .leading(<#T##leading: NSLayoutXAxisAnchor##NSLayoutXAxisAnchor#>, constant: <#T##CGFloat#>))
//        imageView.anchor(.top(fromToView.bottomAnchor, constant: 5))
//        imageView.
        
        let stackView = UIStackView(arrangedSubviews: [
            fromToView.withHeight(80),
            imageView.withSize(.init(width: view.bounds.height * 0.3, height: view.bounds.height * 0.3)),
            titleLabel.withHeight(20),
            label
        ])
        stackView.spacing = 10
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.anchor(.top(topAnchor),
                         .leading(view.leadingAnchor, constant: 16),
                         .trailing(view.trailingAnchor, constant: 16))
//                         .bottom(button.topAnchor, constant: 10))
    }
}

extension MissionPreviewViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionPreviewViewModel) {
        button.rx.tap.bind { () in
            APISource.shared.postMissionSend(
                missionSendingPostData: viewModel.missionSendingData.asMissionSendPostData,
                completion: {
                    viewModel.confirmAction()
            })
        }.disposed(by: rx.disposeBag)
        
        titleLabel.text = viewModel.missionSendingData.mission.missionName
        label.text = viewModel.missionSendingData.content
    }
}
