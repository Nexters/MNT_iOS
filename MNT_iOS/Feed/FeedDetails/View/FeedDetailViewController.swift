//
//  MissionDetailViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FeedDetailViewController: ViewController {
    var viewModel: FeedDetailViewModel?
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "frutto1") , contentMode: .scaleAspectFill)
    private let titleLabel = UILabel(text: "# 닮은꼴 사진 보내기", font: .boldSystemFont(ofSize: 15), textColor: .defaultText)
    private let contentLabel = UILabel(text: "ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어ㅁ나어ㅗㅁ나ㅣ옴나어",
                               font: .systemFont(ofSize: 14), textColor: .lightGray, numberOfLines: 0)
    let fromToView = FromToView()
    
    override func setupLayout() {
        view.addSubview(fromToView)
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        
        fromToView.anchor(.top(topAnchor, constant: 5), .leading(view.leadingAnchor, constant: 15), .height(64), .width(200))
        
        imageView.anchor(.top(fromToView.bottomAnchor), .leading(view.leadingAnchor, constant: 26), .trailing(view.trailingAnchor, constant: 26))
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.layer.cornerRadius = 10
        
        titleLabel.anchor(.top(imageView.bottomAnchor, constant: 24), .leading(imageView.leadingAnchor))
        
        contentLabel.anchor(.top(titleLabel.bottomAnchor, constant: 10), .leading(imageView.leadingAnchor), .trailing(imageView.trailingAnchor))
        
        if viewModel?.feedDetail?.missionId?.isAbleImg == 0 {
            imageView.withHeight(0)
        }
    }
    
    override func setupNavigationController() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "share"),
//                                                            style: .plain,
//                                                            target: self,
//                                                            action: #selector(tapShare))
        navigationController?.navigationBar.tintColor = .defaultText
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc fileprivate func tapShare() {
        // TODO tap share button
    }
}

extension FeedDetailViewController: ViewModelBindableType {
    func bindViewModel(viewModel: FeedDetailViewModel) {
        print("tagg \(viewModel.feedDetail?.missionId?.isAbleImg == 0)")
        imageView.kf.setImage(with: viewModel.feedDetail?.asFeedCellViewModel.postURL)
        titleLabel.text = viewModel.feedDetail?.contentTitle
        contentLabel.text = viewModel.feedDetail?.content
    }
}
