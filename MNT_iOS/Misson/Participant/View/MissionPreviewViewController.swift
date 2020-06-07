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
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "profileFace01"), contentMode: .scaleToFill)
    let titleLabel = UILabel(font: .boldSystemFont(ofSize: 15), numberOfLines: 1)
    let label = UILabel(numberOfLines: 0)
    let fromToView = FromToView()
    fileprivate lazy var button: PrimaryButton = {
        let b = PrimaryButton("완료")
        return b
    }()
    
    override func setupLayout() {
        
        title = "미리보기"
        
        view.addSubview(button)
        button.anchor(.bottom(bottomAnchor))
        button.centerXToSuperview()
        
        view.addSubview(fromToView)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(label)
        
        fromToView.anchor(
            .top(topAnchor, constant: 0),
            .leading(view.leadingAnchor, constant: 15),
            .trailing(view.trailingAnchor, constant: 15))
        fromToView.withHeight(70)

        imageView.anchor(
            .top(fromToView.bottomAnchor, constant: 0),
            .leading(view.leadingAnchor, constant: 26),
            .trailing(view.trailingAnchor, constant: 26)
        )
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        imageView.centerXToSuperview()
        imageView.layer.cornerRadius = 10
        
        if viewModel?.imageData == nil {
            imageView.withHeight(0)
        }
        
                
        titleLabel.anchor(
             .top(imageView.bottomAnchor, constant: 24),
             .leading(imageView.leadingAnchor))
        label.anchor(
            .top(titleLabel.bottomAnchor, constant: 10),
            .leading(imageView.leadingAnchor),
            .trailing(imageView.trailingAnchor)
        )
    }
}

extension MissionPreviewViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionPreviewViewModel) {
        button.rx.tap.bind { () in
            APISource.shared.postMissionSend(
                missionSendingPostData: viewModel.missionSendingPostData,
                completion: {
                    viewModel.confirmAction()
            })
        }.disposed(by: rx.disposeBag)
        
        imageView.image = viewModel.imageData?.image
//        imageView.image = viewModel.missionSendingPostData.img!.image
        titleLabel.text = viewModel.missionSendingData.mission.missionName
        label.text = viewModel.missionSendingData.content
    }
}
