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
    
    let maxLabel = UILabel(text: "👻몇 명이서 하실 건가요?👻", numberOfLines: 0)
    let maxTF = UITextField(placeholder: "최대 정원 설정")
    let dateLabel = UILabel(text: "👻얼마동안 하실 건가요?👻", numberOfLines: 0)
    var beginDateTF = UITextField()
    var endDateTF = UITextField()
    var datePicker = UIDatePicker()
    var button = UIButton(title: "방 만들기 ", titleColor: .black)
    //var button = UIBarButtonItem(title: "다음", style: .plain, target: self, action: nil)
    var textFieldName: UITextField!
    
    var viewModel: SetRoomDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationItem.rightBarButtonItem = button
    }
    
    override func setupLayout() {
        datePicker.timeZone = NSTimeZone.local
        beginDateTF.borderStyle = .roundedRect
        endDateTF.borderStyle = .roundedRect
        
        view.stack(maxLabel.withHeight(50),
                   maxTF.withHeight(50),
                   dateLabel.withHeight(50),
                   view.hstack(beginDateTF.withWidth(view.frame.width/3).withHeight(50),
                               endDateTF.withWidth(view.frame.width/3).withHeight(50))
                        .withMargins(.init(top: 0, left: 10, bottom: 0, right: 10)),
                   button.withHeight(50),
                   alignment: .center,
                   distribution: .equalSpacing)
            .withMargins(.init(top: view.frame.height/2 - 300,
                               left: 0,
                               bottom: view.frame.height/2 - 200,
                               right: 0))
    }
    
}

extension SetRoomDetailViewController: ViewModelBindableType {
    func bindViewModel(viewModel: SetRoomDetailViewModel) {
        button.rx.action = viewModel.presentReadyAction()
        
        maxTF.rx.text.orEmpty
            .bind(to: viewModel.maxRelay)
            .disposed(by: rx.disposeBag)
        
        beginDateTF.rx.text.orEmpty
            .bind(to: viewModel.beginDateRelay)
            .disposed(by: rx.disposeBag)
        
        endDateTF.rx.text.orEmpty
            .bind(to: viewModel.endDateRelay)
            .disposed(by: rx.disposeBag)

        beginDateTF.rx.controlEvent(UIControl.Event.allTouchEvents)
            .subscribe({ [weak self] _ in
                self!.textFieldName = self!.beginDateTF
                self!.createDatePicker()
            })
            .disposed(by: rx.disposeBag)
        
        endDateTF.rx.controlEvent(UIControl.Event.allTouchEvents)
        .subscribe({ [weak self] _ in
            self!.textFieldName = self!.endDateTF
            self!.createDatePicker()
        })
        .disposed(by: rx.disposeBag)
    }
    
    // Should Move createDatePicker(), donePressed() to SetRoomDetailViewModel - try using Relay
    func createDatePicker() {
        let toolbar = UIToolbar()
        
        var doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(donePressed(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.sizeToFit()
        toolbar.items = [flexibleSpace, doneButton]
        textFieldName.inputAccessoryView = toolbar
        textFieldName.inputView = datePicker
    }
    
    @objc func donePressed(_ sender : Any) {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        self.textFieldName.text = dateFormatter.string(from: datePicker.date)

        UIApplication.topViewController()?.view.endEditing(true)
    }
}
