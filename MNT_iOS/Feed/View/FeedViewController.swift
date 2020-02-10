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
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.registerNib(FeedCell.self)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}

fileprivate let dummyImage = "https://image.shutterstock.com/image-vector/user-icon-260nw-523867123.jpg"
fileprivate let dummmyPostImageURL = "https://www.goodmorningcc.com/news/photo/201807/92806_109217_2652.jpg"

extension FeedViewController: ViewModelBindableType {
    func bindViewModel(viewModel: FeedViewModel) {
        // setup Dummys
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
        self.tableView.reloadSection(section: 0)
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel?.infos.count)
        return viewModel?.infos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FeedCell.self)
        guard let item = viewModel?.infos[indexPath.row] else { return UITableViewCell(frame: .zero)}
        cell.bindViewModel(viewModel: item.asFeedCellViewModel)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                print("Unhide")
            }, completion: nil)
        }
    }
}
