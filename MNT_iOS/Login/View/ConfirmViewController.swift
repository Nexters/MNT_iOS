//
//  ConfirmViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class ConfirmViewController: ViewController {
    var viewModel: ConfirmViewModel?
    let nicknameLabel = UILabel(text: "")
    let profileImageView = CircularImageView(width: 100)
    let nameSubLabel = UILabel(text: "이름")
    var nameLabel = UILabel(text: "내이름은이제부터조야")
    let IDSubLabel = UILabel(text: "카카오 ID")
    var IDLabel = UILabel(text: "카카오 아이디이이이익익익익!!!")
    var button = AccentButton("푸르또 시작하기🍎")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        requestMe()
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        self.navigationController?.title = "\(nicknameLabel)님, 반가워요!"
        view.stack(view.hstack(UIView().withWidth(width * 0.35),
                               profileImageView.withHeight(height * 0.156)
                                               .withWidth(width * 0.3),
                               UIView().withWidth(width * 0.35)),
                   UIView().withHeight(height * 0.096),
                   view.hstack(UIView().withWidth(width * 0.096),
                               nameSubLabel.withHeight(height * 0.016)
                                           .withWidth(width * 0.061),
                               UIView().withWidth(width * 0.843)),
                   UIView().withHeight(height * 0.011),
                   view.hstack(UIView().withWidth(width * 0.096),
                               nameLabel.withHeight(height * 0.021)
                                        .withWidth(width * 0.8),
                               UIView().withWidth(width * 0.104)),
                   UIView().withHeight(height * 0.046),
                   view.hstack(UIView().withWidth(width * 0.096),
                               IDSubLabel.withHeight(height * 0.016)
                                          .withWidth(width * 0.131),
                               UIView().withWidth(width * 0.773)),
                   UIView().withHeight(height * 0.007),
                   view.hstack(UIView().withWidth(width * 0.096),
                               IDLabel.withHeight(height * 0.021)
                                      .withWidth(width * 0.8),
                               UIView().withWidth(width * 0.104)),
                   UIView().withHeight(height * 0.138),
                   view.hstack(UIView().withWidth(width * 0.053),
                               button.withHeight(height * 0.069)
                                     .withWidth(width * 0.893),
                               UIView().withWidth(width * 0.053)))
            .withMargins(.init(top: height * 0.129, left: 0, bottom: height * 0.11, right: 0))
    }
    
    fileprivate func requestMe() {
        KOSessionTask.userMeTask { [unowned self] (error, me) in
            guard
                let me = me,
                let account = me.account,
                let profileImageUrl = account.profile?.profileImageURL
                else {return}

            self.nicknameLabel.text = me.nickname
//            self.IDLabel.text = me.account
            self.profileImageView.kf.setImage(with: profileImageUrl)
        }
    }
}

extension ConfirmViewController: ViewModelBindableType {
    func bindViewModel(viewModel: ConfirmViewModel) {
        
    }
}

