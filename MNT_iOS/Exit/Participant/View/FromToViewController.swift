//
//  FromToViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class FromToViewController: ViewController {
    var viewModel: ProfileCellViewModel?
    let manittoImageView = CircularImageView(width: 30, image: .none)
    let manittoLabel = UILabel(text: "나", font: .systemFont(ofSize: 18))
    let targetImageView = CircularImageView(width: 30, image: .none)
    let targetLabel = UILabel(text: "너", font: .systemFont(ofSize: 18))

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupLayout() {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view = containerView
        self.preferredContentSize.width = self.view.frame.width
        self.preferredContentSize.height = self.view.frame.height
        
        view.hstack(manittoImageView,
               manittoLabel,
               UIImageView(image: nil, contentMode: .scaleAspectFit).withWidth(60),
               targetImageView,
               targetLabel)
    }
}

extension FromToViewController: ViewModelBindableType {
    func bindViewModel(viewModel: ProfileCellViewModel) {
        manittoImageView.kf.setImage(with: viewModel.manittoImageURL)
        targetImageView.kf.setImage(with: viewModel.targetImageURL)
        manittoLabel.text = viewModel.datas.manittoName
        targetLabel.text = viewModel.datas.targetName
    }
}
