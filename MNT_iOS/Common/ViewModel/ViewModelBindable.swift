//
//  ViewModelProtocol.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/27.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation


// ViewModel 을 사용하는 모든 ViewController가 채택해야하는 Protocol
protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType? { get set }
    func bindViewModel(viewModel: ViewModelType)
}

extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        // execute on viewDidLoad
        guard let viewModel = self.viewModel else { return }
        bindViewModel(viewModel: ViewModelType)
    }
}
