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
    let titleLabel = UILabel(text: "참가자 리스트", numberOfLines: 0)
    let descriptionLabel = UILabel(text: "마니또가 종료되었습니다.\n마니또를 공개하기 전에\n~~~님의 마니또를 맞춰보세요!", numberOfLines: 0)
    var button = UIButton(title: "선택 완료", titleColor: .black)
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width/3 , height: self.view.frame.height/20)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.registerNib(ProfileCollectionViewCell.self)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
//        view.addSubview(collectionView)
//        collectionView.fillSuperview()
        
        view.stack(titleLabel,
                   descriptionLabel,
                   collectionView.withHeight(100),
                   button,
                   distribution: .fillEqually)
    }
}

let dummyImage = "https://image.shutterstock.com/image-vector/user-icon-260nw-523867123.jpg"

extension GuessViewController: ViewModelBindableType {
    func bindViewModel(viewModel: GuessViewModel) {
        (0...8).forEach {
            self.viewModel?.profiles.append(ManittoProfile(manittoName: "마니또\($0)", manittoProfileImageURL: dummyImage))
        }
        
        collectionView.reloadData()
        
        button.rx.action = viewModel.openAlertAction()
    }
}

extension GuessViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

        //이벤트처리
        
    }

}
