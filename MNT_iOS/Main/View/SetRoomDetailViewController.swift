//
//  SetRoomDetailViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class SetRoomDetailViewController: ViewController {
    
    let descriptionLabel = UILabel(text: "👻설명 추가 예정👻", numberOfLines: 0)
    let textField = UITextField(placeholder: "최대 정원 설정")
    var beginDate = UIDatePicker()
    var endDate = UIDatePicker()
    var button = UIButton(title: "방 만들기", titleColor: .black)
    
    var viewModel: SetRoomDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
        beginDate.timeZone = NSTimeZone.local
        endDate.timeZone = NSTimeZone.local
        beginDate.addTarget(self, action: #selector(SetRoomDetailViewController.datePickerValueChanged(_:)), for: .valueChanged)
        endDate.addTarget(self, action: #selector(SetRoomDetailViewController.datePickerValueChanged(_:)), for: .valueChanged)
        
        view.stack(descriptionLabel.withHeight(50),
                   textField.withHeight(50),
                   beginDate.withHeight(50),
                   endDate.withHeight(50),
                   button.withHeight(50),
                   alignment: .center)
        .withMargins(.init(top: view.frame.height/2 - 300,
                                left: 0,
                                bottom: view.frame.height/2 - 300,
                                right: 0))
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        print("Selected value \(selectedDate)")
    }
    
}

extension SetRoomDetailViewController: ViewModelBindableType {
    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        button.rx.action = viewModel.presentReadyAction()
    }
}
