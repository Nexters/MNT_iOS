//
//  AgreeViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/05/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class AgreeViewController: ViewController {
    var viewModel: AgreeViewModel?
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    var button = PrimaryButton("알겠습니다🤙")
    
    let label: UILabel = {
        let l = UILabel()
        if let filePath = Bundle.main.path(forResource: "agreement", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filePath)
                l.text = contents
            } catch {
                l.text = "이용약관"
            }
        } else {
            l.text = "이용약관"
        }
        l.numberOfLines = 0
        l.sizeToFit()
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func setupNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "이용약관"
    }
    
    override func setupLayout() {
        setupScrollView()
        setupViews()
    }
    
    func setupScrollView(){
        let width = view.frame.width
        let height = view.frame.height
               
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(button)

        
        scrollView.anchor(
            .top(view.topAnchor, constant: height * 0.2),
            .bottom(view.bottomAnchor, constant: height * 0.35),
            .leading(view.leadingAnchor, constant: 30),
            .trailing(view.trailingAnchor, constant: 30)
        )
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        button.anchor(
            .bottom(view.bottomAnchor, constant: height * 0.14)
        )
        button.centerXToSuperview()
    }
    
    func setupViews(){
        contentView.addSubview(label)
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

extension AgreeViewController: ViewModelBindableType {
    func bindViewModel(viewModel: AgreeViewModel) {
        button.rx.action = viewModel.presentConfirmAction()
    }
}
