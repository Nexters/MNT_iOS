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
        let tb = UITableView(frame: .zero, style: .grouped)
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.backgroundColor = .white
        tb.sectionHeaderHeight = 64
        tb.contentInset = .init(top: 5, left: 0, bottom: 0, right: 0)
        tb.addSubview(self.refreshControl)
        tb.registerNib(FeedCell.self)
        tb.showsVerticalScrollIndicator = false
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    fileprivate var userlistBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "people").withRenderingMode(.alwaysOriginal),
                                                        style: .plain,
                                                        target: nil,
                                                        action: nil)
    fileprivate var filterBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "options2").withRenderingMode(.alwaysOriginal),
                                                      style: .plain,
                                                      target: nil,
                                                      action: nil)
    
    fileprivate lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.accentColor
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFeedButtonObserver()
    }
    
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
        self.navigationItem.setRightBarButtonItems([filterBarButton, userlistBarButton], animated: true)
    }
}

extension FeedViewController: ViewModelBindableType {
    func bindViewModel(viewModel: FeedViewModel) {
        // setup Dummys
        self.viewModel = viewModel
        
        userlistBarButton.rx.action = viewModel.userListAction()
        filterBarButton.rx.action = viewModel.feedFilterAction()
        tableView.rx.itemSelected
            .subscribe(viewModel.feedDetailAction(_:))
            .disposed(by: rx.disposeBag)
        
        getTimeline()
    }
    
    private func getTimeline() {
        APISource.shared.getTimeline(roomId: 0) { missions in
            //print(missions)
        }
        
        (0...2).forEach{ [unowned self] i in
            self.viewModel?.infos.append(Feed(id: 1,
                                              content: String(i),
                                              missionId: MissionId(isAbleImg: 1),
                                              missionImg: "https://img.huffingtonpost.com/asset/5c6a1b8a250000be00c88cae.png?cache=41JoK4KsMg&ops=scalefit_630_noupscale",
                                              roodId: 1,
                                              userDone: 0,
                                              userDoneTime: "12:30",
                                              userId: "its me"))
        }
        (0...5).forEach{ [unowned self] i in
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
    
    func addFeedButtonObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moveToTop(_:)),
                                               name: NSNotification.Name("TabFeedButtonAgain"),
                                               object: nil)
    }
    
    @objc func moveToTop(_ notification: Notification) {
        tableView.contentOffset = CGPoint(x: 0,
                                          y: 0 - (44 + tableView.contentInset.top + (self.navigationController?.navigationBar.frame.size.height)!))
    }
    
    @objc func handleRefresh(_ sender: Any) {
        getTimeline()
        self.refreshControl.endRefreshing()
    }
}

// MARK:- UITableViewControllerProtocols
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.infos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.infos[indexPath.row] else { return UITableViewCell(frame: .zero)}
        let cell = tableView.dequeueReusableCell(FeedCell.self)
        cell.bindViewModel(viewModel: item.asFeedCellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        FeedHeaderView(user: User())
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        64
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // call delegate
        let userInfo: [AnyHashable: Any]
        
        if(velocity.y>0) {  // HIDE
            userInfo = ["TabBarAction":"HIDE"]
            
            UIView.animate(withDuration: 1.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }, completion: nil)
            
        } else {            // SHOW
            userInfo = ["TabBarAction":"SHOW"]
            
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }, completion: nil)
        }
        
        NotificationCenter.default.post(name: Notification.Name("ScrollAction"),
                                        object: self,
                                        userInfo: userInfo)
    }
}
