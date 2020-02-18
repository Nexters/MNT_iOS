//
//  FeedFilterCellFooter.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class FeedFilterCellFooterView: UIView {
    fileprivate var subMenus: [FeedFilterSubMenu] = []
    fileprivate lazy var tableView: UITableView = {
          let tb = UITableView()
          tb.delegate = self
          tb.dataSource = self
          tb.separatorStyle = .none
          tb.allowsSelection = true
          tb.registerNib(FeedFilterSubmenuCell.self)
          tb.showsVerticalScrollIndicator = false
          tb.contentInset = .init(top: 15, left: 0, bottom: 0, right: 0)
          return tb
    }()
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            let inset: CGFloat = 26
            var frame = newFrame
            frame.origin.x += inset
            frame.size.width -= 2 * inset
            super.frame = frame
        }
    }
    
    init(subMenus: [FeedFilterSubMenu]) {
        self.subMenus = subMenus
        super.init(frame: .zero)
        
        addSubview(tableView)
        tableView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 25, right: 0))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        tableView.layer.masksToBounds = false
        tableView.layer.cornerRadius = 15
        tableView.roundedBorder(corners: [.allCorners], radius: 15)
        tableView.setupShadow(opacity: 0.06,
                    radius: 15,
                    offset: .init(width: 0, height: 1))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedFilterCellFooterView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subMenus.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FeedFilterSubmenuCell.self)
        cell.setupLayout(menu: subMenus[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("footer tableview cell selected...")
    }
}
