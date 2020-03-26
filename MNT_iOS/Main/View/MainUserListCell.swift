//
//  MainUserListCell.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/03/25.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MainUserListCell: UITableViewCell {
    
//    var viewModel: MainUserListCellViewModel?
    var viewModel : MainUserListViewModel?
    
    let profileImage = CircularImageView(width: 60, image: #imageLiteral(resourceName: "profileFace01"))
    let nameLabel = UILabel(text: "마니또",
                            font: .semiBoldFont(ofSize: 15),
                            textColor: .defaultText,
                            textAlignment: .left,
                            numberOfLines: 0)
    var deleteButton = UIButton(image: #imageLiteral(resourceName: "logOut"),
                                tintColor: .gray)
    let logoutImage = UIImageView(image: #imageLiteral(resourceName: "logOut"))
    lazy var stackView: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [
        profileImage,
        nameLabel
       ])
        sv.axis = .horizontal
        sv.spacing = 0
        return sv
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(stackView)
        addSubview(deleteButton)
        
        stackView.centerYToSuperview()
        deleteButton.centerYToSuperview()
        stackView.anchor(.leading(leadingAnchor, constant: 20))
        deleteButton.anchor(.trailing(trailingAnchor, constant: 30))
        
//        self.deleteButton.addTarget(self,
//                                    action: #selector(buttonTapped(_:)),
//                                    for: .touchUpInside)
    }
    
//    @objc func buttonTapped(_ sender: UIButton) {
//        let cell = sender.superview as! UITableViewCell
//        let tableView = cell.superview as! UITableView
//        let indexPath = tableView.indexPath(for: cell)
//        let targetCell =
//
////        let alert = UIAlertController(title: "진짜",
////                                      message: "내보낼 거야?",
////                                      preferredStyle: <#T##UIAlertController.Style#>)
//
////        let alert = UIAlertController(title: "Subscribed!", message: "Subscribed to \(youtuber)", preferredStyle: .alert)
////        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
////        alert.addAction(okAction)
////
////        self.present(alert, animated: true, completion: nil)
//    }
}

//extension MainUserListCell: ViewModelBindableType {
//    func bindViewModel(viewModel: MainUserListCellViewModel) {
//
//    }
//}
