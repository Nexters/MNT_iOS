//
//  FeedViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FeedViewModel: ViewModel {
    var infos: [Feed] = []
    
    func userListAction() -> CocoaAction {
          return Action { [unowned self] _ in
            let viewModel = UserListViewModel(title: "참여자 리스트", coordinator: self.coordinator)
            let scene = FeedScene.userList(viewModel)
            BottomBar.shared.hideBottomBar()
            return self.coordinator
                .transition(to: scene,
                            using: .push,
                            animated: true)
                .asObservable().map { _ in }
        }
    }
    
    func feedFilterAction() -> CocoaAction {
          return Action { [unowned self] _ in
            let viewModel = FeedFilterViewModel(title: "미션 등록",
                                                   coordinator: self.coordinator)
            let scene = FeedScene.filter(viewModel)
            return self.coordinator
                .transition(to: scene,
                            using: .modal,
                            animated: true)
                .asObservable().map { _ in }
          }
    }
    
    func feedDetailAction(_ indexPath: Event<IndexPath>) {
        
        guard let index = indexPath.element?.row else { return }
        
        let viewModel = FeedDetailViewModel(title: "미션 등록",
                                            coordinator: self.coordinator, feedDetail: infos[index])
        let scene = FeedScene.feedDetail(viewModel)
        BottomBar.shared.hideBottomBar()
        self.coordinator
            .transition(to: scene,
                        using: .push,
                        animated: true)
    }
}

