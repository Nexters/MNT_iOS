//
//  SetRoomDetailViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class SetRoomDetailViewController: ViewController {
    
    var viewModel: SetRoomDetailViewModel?
    let dashLabel = UILabel(text: "~")
    var beginDateTF = UITextField()
    var endDateTF = UITextField()
    var datePicker = UIDatePicker()
    var textFieldName: UITextField!
    var button = PrimaryButton("방 만들기")
    
    let maxLabel = UILabel(text: "몇명이서 하실 건가요? 👭",
                           font: .systemFont(ofSize: 18),
                           textColor: .defaultText,
                           textAlignment: .left,
                           numberOfLines: 0)
    
    let maxSubLabel = UILabel(text: "명",
                              font: .systemFont(ofSize: 18),
                              textColor: .defaultText,
                              textAlignment: .left,
                              numberOfLines: 0)
    
    let dateLabel = UILabel(text: "얼마동안 하실 건가요? ⏱",
                            font: .systemFont(ofSize: 18),
                            textColor: .defaultText,
                            textAlignment: .left,
                            numberOfLines: 0)
    
    let maxTF : UITextField = {
        let tf = UITextField(placeholder: "Enter")
        tf.keyboardType = .numberPad
        return tf
    }()
    
    lazy var maxStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            maxTF, maxSubLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 5
        return sv
    }()
    
    lazy var dateStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            beginDateTF, dashLabel, endDateTF
        ])
        sv.axis = .horizontal
        sv.spacing = 10
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonToTextField(textField: maxTF)
        datePicker.timeZone = NSTimeZone.local
        beginDateTF.borderStyle = .roundedRect
        endDateTF.borderStyle = .roundedRect
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        view.addSubview(maxLabel)
        view.addSubview(maxStack)
        view.addSubview(dateLabel)
        view.addSubview(dateStack)
        view.addSubview(button)
        
        maxLabel.anchor(
            .top(view.topAnchor, constant: height * 0.28),
            .leading(view.leadingAnchor, constant: width * 0.069))
        maxStack.anchor(
            .top(maxLabel.bottomAnchor, constant: height * 0.05),
            .leading(view.leadingAnchor, constant: width * 0.069)
        )
        dateLabel.anchor(
            .top(maxLabel.bottomAnchor, constant: height * 0.187),
            .leading(view.leadingAnchor, constant: width * 0.069)
        )
        dateStack.anchor(
            .top(maxLabel.bottomAnchor, constant: height * 0.255)
        )
        button.anchor(
            .top(maxLabel.bottomAnchor, constant: height * 0.353)
        )
        dateStack.centerXToSuperview()
        button.centerXToSuperview()
        beginDateTF.constrainWidth(width * 0.35)
        endDateTF.constrainWidth(width * 0.35)
    }
    
    func addButtonToTextField(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let nextBtn = UIBarButtonItem(title: "done", style: .done, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexibleSpace, nextBtn]
        maxTF.inputAccessoryView = toolBar
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
