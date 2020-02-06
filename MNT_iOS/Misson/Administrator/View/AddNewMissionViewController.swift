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
    lazy var view1: UIView = {
        let v = StackChildView()
        v.backgroundColor = .yellow
        //v.propotionalHeight = 1
        v.withHeight(view.bounds.height * 0.3)
        return v
    }()
    lazy var view2: UIView = {
        let v = StackChildView()
        v.backgroundColor = .blue
        //v.propotionalHeight = 2
        v.withHeight(view.bounds.height * 0.2)
        return v
    }()
    lazy var view3: UIView = {
        let v = StackChildView()
        v.backgroundColor = .red
//        v.propotionalHeight = 1
        v.withHeight(view.bounds.height * 0.1)
        return v
    }()
    let button: UIButton = {
        return UIButton(title: "hellow!", titleColor: .black)
    }()
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            view1, view2, view3
        ])
        sv.axis = .vertical
        sv.spacing = 5
        //sv.distribution = .fillProportionally
        
       return sv
    }()
    
    override func setupLayout() {
        view.addSubview(stackView)
        view.addSubview(button)
        button.anchor(.bottom(view.refinedBottomAnchor, constant: 10))
        button.centerXToSuperview()
        stackView.anchor(top: view.refinedTopAnchor,
                         leading: view.leadingAnchor,
                         bottom: nil,
                         trailing: view.trailingAnchor)
        
    }
}

extension AddNewMissionViewController: ViewModelBindableType {
    func bindViewModel(viewModel: AddNewMissionViewModel) {
        
    }
}
