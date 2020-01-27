//
//  ViewModelProtocol.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/27.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation


// ViewModel 을 사용하는 모든 ViewController가 채택해야하는 Protocol
protocol ViewModelProtocol {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType? { get set }
    func bind()
}

extension ViewModelProtocol where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bind()
    }
}
