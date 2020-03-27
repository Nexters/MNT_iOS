//
//  MissionTableViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import RxCocoa
import RxGesture

class MissionTableViewController: UITableViewController {
    
    var flag: Int = 0 // 0: pariticipant, 1: administrator
    
    var missions: [Mission] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var ordermissions: [OrderMission] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
        view.backgroundColor = .white
        tableView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .init(top: 45, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.registerNib(MissionCell.self)
        tableView.registerNib(MissionMakeCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BottomBar.shared.showBottomBar()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < tableView.numberOfSections-1 {
            return 1
        }
        return flag == 0 ? missions.count : ordermissions.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        flag == 0 ? 1 : 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < tableView.numberOfSections-1 {
            // for administrator only
            let cell = tableView.dequeueReusableCell(MissionMakeCell.self)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(MissionCell.self)
        
        if flag == 0 { cell.setup(mission: missions[indexPath.row])}
        else { cell.setup(mission: ordermissions[indexPath.row])}
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
    
    /*
     Header
     - section 0 : participant & administrator
     - section 1 : administrator
     */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
           return MissionTitleHeaderView(text: "푸르또를 위해\n미션을 수행해주세요.")
        } else {
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 70
        } else {
            return 0
        }
    }
}

extension MissionTableViewController {
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y > 0 {
            BottomBar.shared.hideBottomBar()
        } else if velocity.y < 0 {
            BottomBar.shared.showBottomBar()
        }
    }
}

class MissionTitleHeaderView: UIView {
    let label = UILabel(text: "푸르또를 위해\n미션을 수행해주세요.", font: .boldFont(ofSize: 20), textColor: .defaultText, numberOfLines: 2)
    
    init(text: String) {
        super.init(frame: .zero)
        label.text = text
        label.setLineSpacing(lineSpacing: 2)
        addSubview(label)
        label.anchor(top: topAnchor, leading: leadingAnchor, padding: .init(top: 0, left: 26, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

