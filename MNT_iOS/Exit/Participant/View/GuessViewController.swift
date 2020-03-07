//
//  GuessViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class GuessViewController: ViewController, UICollectionViewDelegateFlowLayout {
    
    var viewModel: GuessViewModel?
    let descriptionLabel = UILabel(
        text: "마니또가 종료되었습니다.\n마니또를 공개하기 전에\n~~~님의 마니또를 맞춰보세요!",
        font: .mediumFont(ofSize: 14),
        textAlignment: .center,
        numberOfLines: 0)
    let fruitImage = UIImageView(image: #imageLiteral(resourceName: "group2"))
    let bubbleImage = UIImageView(image: #imageLiteral(resourceName: "combinedShape"))
    var button = DisableButton("선택완료")
    var isSelected : Bool?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.registerNib(ProfileCollectionViewCell.self)
        cv.contentInset = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        isSelected = false
        
        view.stack(collectionView)
        view.addSubview(fruitImage)
        view.addSubview(bubbleImage)
        view.addSubview(descriptionLabel)
        view.addSubview(button)
        
        collectionView.anchor(
            .top(view.topAnchor, constant: height * 0.477),
            .leading(view.leadingAnchor, constant: width * 0.069),
            .trailing(view.trailingAnchor, constant: width * 0.069),
            .bottom(view.bottomAnchor, constant: height * 0.16)
        )
        fruitImage.anchor(
            .top(view.topAnchor, constant: height * 0.156)
        )
        bubbleImage.anchor(
            .top(view.topAnchor, constant: height * 0.198)
        )
        descriptionLabel.anchor(
            .top(view.topAnchor, constant: height * 0.219)
        )
        button.anchor(
            .bottom(view.bottomAnchor, constant: height * 0.042)
        )
        
        fruitImage.centerXToSuperview()
        bubbleImage.centerXToSuperview()
        descriptionLabel.centerXToSuperview()
        button.centerXToSuperview()
        collectionView.centerXToSuperview()
        
        fruitImage.constrainWidth(height * 0.157)
        fruitImage.constrainHeight(height * 0.273)
        bubbleImage.constrainWidth(width * 0.589)
        bubbleImage.constrainHeight(height * 0.129)
        descriptionLabel.constrainWidth(width * 0.52)
        descriptionLabel.constrainHeight(height * 0.078)
    }
}

let dummyFromImage = "https://image.shutterstock.com/image-vector/user-icon-260nw-523867123.jpg"
let dummyToImage = "https://image.shutterstock.com/image-vector/user-icon-260nw-523867123.jpg"
let dummyFromLabel = "뚱이"
let dummyToLabel = "핑핑이"

extension GuessViewController: ViewModelBindableType {
    func bindViewModel(viewModel: GuessViewModel) {
        (0...8).forEach {_ in
            self.viewModel?.profiles.append(ManittoProfile(manittoName: dummyFromLabel,
                                                           targetName: dummyToLabel,
                                                           manittoImageURL: dummyFromImage,
                                                           targetImageURL: dummyToImage))
        }
        
        collectionView.rx.itemSelected
            .subscribe(viewModel.collectionViewCellTouchedAction(_:))
            .disposed(by: rx.disposeBag)
        
        button.rx.action = viewModel.openAlertAction(isSelected!)
    }
}

extension GuessViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.416 - 10, height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.profiles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(ProfileCollectionViewCell.self, for: indexPath)
        guard let item = viewModel?.profiles[indexPath.row] else { return UICollectionViewCell(frame: .zero)}
        cell.bind(viewModel: item.asProfileCellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = UIColor.deSelectedColor
        self.button.backgroundColor = .primaryColor
        self.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = UIColor.white
    }
}
