//
//  UITableView+.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
    
    func registerHeaderFooterNib<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        let reuseIdentifier = viewClass.className
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cellClass.className, for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: cellClass.className) as! T
    }
    
    func registerNib<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) {
        let reuseIdentifier = cellClass.className
        self.register(cellClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) -> T {
        return self.dequeueReusableHeaderFooterView(withIdentifier: cellClass.className) as! T
    }
    
    func reloadSection(section: Int, completion: @escaping () -> Void = {}) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.reloadSections(IndexSet(section...section), with: .automatic)
            }, completion: { _ in
                completion()
            })
        }
    }
}
