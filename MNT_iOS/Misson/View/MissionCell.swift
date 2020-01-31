//
//  MissionCell.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MissionCell: UITableViewCell {
    var viewModel: MissionCellViewModel?
    
    let label = UILabel(text: "", font: .systemFont(ofSize: 16), numberOfLines: 1)
    let checkImageView = UIImageView( contentMode: .scaleAspectFit)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkImageView.backgroundColor = .red
        hstack(label,
               checkImageView.withSize(.init(width: 40, height: 40)))
    }
}

extension MissionCell: ViewModelBindableType {
    func bindViewModel(viewModel: MissionCellViewModel) {
        label.text = viewModel.datas.name
        checkImageView.image = viewModel.datas.isDone ? UIImage() : UIImage()
    }
}
