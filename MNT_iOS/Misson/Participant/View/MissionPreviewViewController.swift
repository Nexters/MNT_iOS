//
//  MissionPreviewViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionPreviewViewController: ViewController {
    var viewModel: MissionPostViewModel?
    
    override func setupLayout() {
        // stackView 어떻게 적용할지..
    }
}

extension MissionPreviewViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionPostViewModel) {
        
    }
}
