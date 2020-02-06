//
//  MissionDetailViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionDetailViewController: ViewController {
    var viewModel: MissionDetailViewModel?
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let label = UILabel(numberOfLines: 0)
    let fromToView = FromToView()
    
    override func setupLayout() {
        view.stack(
            fromToView.withHeight(80),
            imageView.withHeight(view.bounds.height * 0.4),
            label.withHeight(view.bounds.height * 0.2),
            spacing: 20,
            type: .exceptBottom
        )
    }
}

extension MissionDetailViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionDetailViewModel) {
        // Demo
        fromToView.manittoLabel.text = viewModel.missionDetail.fromName ?? ""
    }
}
