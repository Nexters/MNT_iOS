//
//  ImageUploadContainer.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/05/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class ImageUploadContainer: UIView {
    fileprivate let label = UILabel(text: "📷 이미지 업로드",
                        font: .systemFont(ofSize: 15),
                        textColor: .defaultText)
    fileprivate let album = UILabel(text: "앨범",
                        font: .systemFont(ofSize: 12),
                        textColor: .accentColor)
    
    init() {
        super.init(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        album.translatesAutoresizingMaskIntoConstraints = false
        
        let arrow = UIImageView(image: #imageLiteral(resourceName: "arrowRight"))
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(album)
        addSubview(arrow)
        
        label.centerYToSuperview()
        label.anchor(.leading(leadingAnchor, constant: 24),
                     .trailing(album.leadingAnchor, constant: 10))
        arrow.centerYToSuperview()
        arrow.anchor(.trailing(trailingAnchor, constant: 16))
        arrow.withSize(.init(width: 24, height: 24))
        album.centerYToSuperview()
        album.anchor(.trailing(arrow.leadingAnchor, constant: 3))
        album.textAlignment = .right
        album.withWidth(45)
        
        backgroundColor = .lightPink
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
    }
    
    func updateLabels(imagePath: String) {
        label.text = imagePath
        album.text = "다시 선택"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
