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
    
    fileprivate lazy var cover: UIView = {
        let v = UIView(backgroundColor: .white)
        return v
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

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addFeedButtonObserver()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: index, animated: true)
        }
        showBottomBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
        hideBottomBar()
    }

    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.anchor(.top(view.topAnchor),
                         .bottom(view.bottomAnchor),
                         .leading(view.leadingAnchor),
                         .trailing(view.trailingAnchor))
        
        view.addSubview(cover)
        cover.anchor(top: view.topAnchor,
                 leading: view.leadingAnchor,
                 trailing: view.trailingAnchor)
        cover.withHeight(90)
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
        
        if velocity.y > 0 {
            hideBottomBar()
            hideNavigationBar()
        } else if velocity.y < 0 {
            showBottomBar()
            showNavigationBar()
        }
    }
    
    fileprivate func showNavigationBar() {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
//            self.cover.transform = .identity
            self.cover.isHidden = false
        }, completion: nil)
    }
    
    fileprivate func hideNavigationBar() {
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            //self.cover.transform = CGAffineTransform(scaleX: 0, y: -0.1)
            self.cover.isHidden = true
        }, completion: nil)
    }
    
    fileprivate func showBottomBar() {
        NotificationCenter.default.post(name: Notification.Name("ScrollAction"),
                                        object: self,
                                        userInfo: ["TabBarAction":"SHOW"])
    }
    
    fileprivate func hideBottomBar() {
        NotificationCenter.default.post(name: Notification.Name("ScrollAction"),
                                        object: self,
                                        userInfo: ["TabBarAction":"HIDE"])
    }
}
