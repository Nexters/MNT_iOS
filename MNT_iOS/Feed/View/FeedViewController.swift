//
//  FeedViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FeedViewController: ViewController {
    
    var viewModel: FeedViewModel?
    
    fileprivate lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.registerNib(FeedCell.self)
        tb.showsVerticalScrollIndicator = false
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    fileprivate var userlistBarButton: UIBarButtonItem = {
        let bt = UIBarButtonItem(image: #imageLiteral(resourceName: "people"), style: .plain, target: nil, action: nil)
        bt.tintColor = .defaultText
        return bt
    }()
    
    fileprivate var filterBarButton: UIBarButtonItem = {
        let bt = UIBarButtonItem(image: #imageLiteral(resourceName: "options2"), style: .plain, target: nil, action: nil)
        bt.tintColor = .defaultText
        return bt
    }()
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.anchor(.top(view.topAnchor),
                         .bottom(view.bottomAnchor),
                         .leading(view.leadingAnchor),
                         .trailing(view.trailingAnchor))
    }
    
    override func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.setRightBarButtonItems([userlistBarButton, filterBarButton], animated: true)
    }
}

extension FeedViewController: ViewModelBindableType {
    func bindViewModel(viewModel: FeedViewModel) {
        // setup Dummys
        self.viewModel = viewModel
        
        userlistBarButton.rx.action = viewModel.userListAction()
        filterBarButton.rx.action = viewModel.feedFilterAction()
        
        getTimeline()
    }
    
    private func getTimeline() {
        (0...7).forEach{ [unowned self] i in
            self.viewModel?.infos.append(Feed(id: 1,
                                                    content: String(i),
                                                    missionId: nil,
                                                    missionImg: "https://img.huffingtonpost.com/asset/5c6a1b8a250000be00c88cae.png?cache=41JoK4KsMg&ops=scalefit_630_noupscale",
                                                    roodId: 1,
                                                    userDone: 0,
                                                    userDoneTime: "12:30",
                                                    userId: "its me"))
        }
        self.tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.infos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FeedCell.self)
        guard let item = viewModel?.infos[indexPath.section] else { return UITableViewCell(frame: .zero)}
        cell.bindViewModel(viewModel: item.asFeedCellViewModel)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // call delegate
        
        if(velocity.y>0) {  // HIDE
            UIView.animate(withDuration: 1.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }, completion: nil)
        } else {            // SHOW
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}
