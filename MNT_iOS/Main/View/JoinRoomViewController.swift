//
//  JoinViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class JoinRoomViewController: ViewController {

    var viewModel: JoinRoomViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
        
    }
    
}

extension JoinRoomViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        
    }
}
