//
//  AddNewMissionViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/06.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class AddNewMissionViewController: ViewController {
    var viewModel: AddNewMissionViewModel?
    let view1: UIView = {
        let v = StackChildView()
        v.backgroundColor = .yellow
        v.propotionalHeight = 1
        return v
    }()
    let view2: UIView = {
        let v = StackChildView()
        v.backgroundColor = .blue
        v.propotionalHeight = 2
        return v
    }()
    let view3: UIView = {
        let v = StackChildView()
        v.backgroundColor = .red
        v.propotionalHeight = 1
        return v
    }()
    let button: UIButton = {
        return UIButton(type: .system)
    }()
    
    override func setupLayout() {
        view.backgroundColor = .green
        
        let stackView = UIStackView(arrangedSubviews: [
            view1,
            view2,
            view3])
        view.addSubview(stackView)
        stackView.fillSuperview()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        button.bottomAnchor.constraint(equalTo: view.refinedBottomAnchor).isActive = true
    }
}

extension AddNewMissionViewController: ViewModelBindableType {
    func bindViewModel(viewModel: AddNewMissionViewModel) {
        
    }
}
