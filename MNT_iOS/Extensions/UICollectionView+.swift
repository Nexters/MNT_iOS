//
//  UICollectionView+.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func registerSupplementaryNib<T: UICollectionReusableView>(_ viewClass: T.Type, isHeaderFooter: Int) {
        let stringName = isHeaderFooter == 0 ? UICollectionView.elementKindSectionHeader : UICollectionView.elementKindSectionFooter
        let reuseIdentifier = viewClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: stringName, withReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cellClass.className, for: indexPath) as! T
    }
    
    func dequeueReusableSupplement<T: UICollectionReusableView>(_ cellClass: T.Type, kind: String, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellClass.className, for: indexPath) as! T
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func reloadSection(section: Int, animation: Bool = true) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animation ? 0.5 : 0, animations: {
                self.reloadSections(IndexSet(section...section))
            })
        }
    }
    
    func reloadItemsWithAnimation(at: [IndexPath]) {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.reloadItems(at: at)
                          }, completion: nil)
    }
}

extension UITableViewCell {
    func setBasicHorizontalMargin(){
        let newWidth = frame.width * 0.80 // get 80% width here
        let space = (frame.width - newWidth) / 2
        frame.size.width = newWidth
        frame.origin.x += space
    }
}
