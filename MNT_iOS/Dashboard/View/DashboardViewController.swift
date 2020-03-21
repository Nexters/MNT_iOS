//
//  DashboardViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class DashboardViewController: ViewController {
    var viewModel: DashboardViewModel?
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.registerNib(DashboardProfileCell.self)
        cv.registerNib(DashboardGridMenuCell.self)
        cv.registerNib(DashboardListMenuCell.self)
        cv.contentInset = .init(top: 20, left: 26, bottom: 150, right: 26)
        cv.allowsSelection = false
        cv.isUserInteractionEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .customedBackgrounColor
        return cv
    }()
    
    override func setupLayout() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension DashboardViewController: ViewModelBindableType {
    func bindViewModel(viewModel: DashboardViewModel) {
        
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    enum CellType: Int, CodingKey {
        case profile = 0
        case gridMenu = 1
        case listMenu = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width
        
        switch CellType(intValue: indexPath.section) {
        case .profile:
            return .init(width: width, height: 100)
        case .gridMenu:
            width = width * 0.408
            return .init(width: width, height: width * 1.08)
        case .listMenu:
            return .init(width: width, height: 50)
        case .none:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch CellType(intValue: section) {
        case .profile:
            return 1
        case .gridMenu:
            return 6
        case .listMenu:
            return 2
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch CellType(intValue: section) {
        case .profile:
            return 1
        case .gridMenu:
            let space = collectionView.bounds.width * 0.045
            return space
        case .listMenu:
            return 10
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch CellType(intValue: section) {
        case .profile:
            return 1
        case .gridMenu:
            let space = collectionView.bounds.width * 0.045
            return space
        case .listMenu:
            return 10
        case .none:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch CellType(intValue: indexPath.section) {
        case .profile:
            let cell = collectionView.dequeueReusableCell(DashboardProfileCell.self, for: indexPath)
            cell.setupView()
            return cell
        case .gridMenu:
            guard let gridMenu = viewModel?.gridMenu[indexPath.row] else { return UICollectionViewCell(frame: .zero)}
            let cell = collectionView.dequeueReusableCell(DashboardGridMenuCell.self, for: indexPath)
            cell.setupView(gridMenu: gridMenu)
            return cell
        case .listMenu:
            guard let listMenu = viewModel?.listMenu[indexPath.row] else { return UICollectionViewCell(frame: .zero)}
            let cell = collectionView.dequeueReusableCell(DashboardListMenuCell.self, for: indexPath)
            cell.setupView(listMenu: listMenu)
            
            return cell
        case .none:
            return UICollectionViewCell(frame: .zero)
        }
    }
}
