//
//  TextFieldContainer.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/21.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class TextFieldContainer: UIView {

    let label: UILabel = {
        let label = UILabel()
        label.text = "0/200"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.anchor(.bottom(bottomAnchor, constant: 17), .trailing(trailingAnchor, constant: 20))
    }
    
    func updateLabel(count: Int) {
        label.text = "\(count)/200"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
