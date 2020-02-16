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
    var beginDateTF = UITextField()
    var endDateTF = UITextField()
    var datePicker = UIDatePicker()
    var touchedtextField : UITextField!
    var button = PrimaryButton("방 만들기")
    
    let dashLabel = UILabel(text: "~",
                            font: .semiBoldFont(ofSize: 19))
    
    let maxLabel = UILabel(text: "몇명이서 하실 건가요? 👭",
                           font: .boldFont(ofSize: 18),
                           textColor: .defaultText,
                           textAlignment: .left,
                           numberOfLines: 0)
    
    let maxSubLabel = UILabel(text: "명",
                              font: .boldFont(ofSize: 18),
                              textColor: .defaultText,
                              textAlignment: .left,
                              numberOfLines: 0)
    
    let dateLabel = UILabel(text: "얼마동안 하실 건가요? ⏱",
                            font: .boldFont(ofSize: 18),
                            textColor: .defaultText,
                            textAlignment: .left,
                            numberOfLines: 0)
    
    let maxTF : UITextField = {
        let tf = UITextField(placeholder: "")
        tf.keyboardType = .numberPad
        tf.constrainWidth(45)
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
        datePicker.timeZone = NSTimeZone.local
        beginDateTF.borderStyle = .roundedRect
        endDateTF.borderStyle = .roundedRect
        addDoneButtonToTextField(textField: maxTF)
        addDoneButtonToTextField(textField: beginDateTF)
        addDoneButtonToTextField(textField: endDateTF)
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
            .top(view.topAnchor, constant: height * 0.18),
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
    
     override func viewDidLayoutSubviews() {
        setTextFieldUnderLine(beginDateTF)
        setTextFieldUnderLine(endDateTF)
        setTextFieldUnderLine(maxTF)
    }
    
    func setTextFieldUnderLine(_ tf: UITextField) {
        let border = CALayer()
        let width = CGFloat(1.0)
        
        tf.borderStyle = .none
        tf.textAlignment = .center
        
        border.borderColor = UIColor.moreText.cgColor
        border.frame = CGRect(x: 0,
                              y: tf.frame.size.height - width,
                              width:  tf.frame.size.width,
                              height: tf.frame.size.height)
        border.borderWidth = width
        tf.layer.addSublayer(border)
        tf.layer.masksToBounds = true
    }
    
    func addDoneButtonToTextField(textField: UITextField){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "done",
                                      style: .done,
                                      target: self,
                                      action: #selector(donePressed(_:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexibleSpace, doneBtn]
        textField.inputAccessoryView = toolBar
    }
    
    func createDatePicker(textField: UITextField) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        textField.text = dateFormatter.string(from: datePicker.date)
        textField.inputView = datePicker
    }
    
    @objc func donePressed(_ sender: Any) {
        if touchedtextField != maxTF {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
            touchedtextField.text = dateFormatter.string(from: datePicker.date)
        }
        UIApplication.topViewController()?.view.endEditing(true)
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
        
        maxTF.rx.controlEvent(UIControl.Event.allTouchEvents)
            .subscribe({ [weak self] _ in
                self!.touchedtextField = self!.maxTF
            })
            .disposed(by: rx.disposeBag)

        beginDateTF.rx.controlEvent(UIControl.Event.allTouchEvents)
            .subscribe({ [weak self] _ in
                self!.touchedtextField = self!.beginDateTF
                self!.createDatePicker(textField: self!.beginDateTF)
            })
            .disposed(by: rx.disposeBag)
        
        endDateTF.rx.controlEvent(UIControl.Event.allTouchEvents)
        .subscribe({ [weak self] _ in
            self!.touchedtextField = self!.endDateTF
            self!.createDatePicker(textField: self!.endDateTF)
        })
        .disposed(by: rx.disposeBag)
    }
}
