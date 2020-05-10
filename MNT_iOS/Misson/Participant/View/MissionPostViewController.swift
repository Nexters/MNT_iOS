//
//  MissionDetailViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MissionPostViewController: ViewController {
    var viewModel: MissionPostViewModel?
    
    fileprivate let titleLabel = UILabel(text: "title", font: .boldSystemFont(ofSize: 20))
    fileprivate let subtitleLabel = UILabel(text: "subtitle", font: .systemFont(ofSize: 16), textColor: .defaultText)
    fileprivate lazy var button: PrimaryButton = {
        let b = PrimaryButton("미션 등록하기")
        b.isEnabled = false
        return b
    }()
    fileprivate let textfieldContainer = TextFieldContainer()
    
    fileprivate var imageUploadContainer = ImageUploadContainer()
    
    fileprivate let placeholder = "텍스트를 입력해주세요."
    fileprivate lazy var textView: UITextView = {
        let tv = UITextView(frame: .zero)
        tv.backgroundColor = .clear
        tv.delegate = self
        tv.text = placeholder
        tv.textColor = .lightGray
        return tv
    }()
    
    fileprivate lazy var titleStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])
        sv.axis = .vertical
        return sv
    }()
    
    fileprivate lazy var wholeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleStackView.withHeight(70),
            textfieldContainer.withHeight(view.bounds.height * 0.27),
        ])
        sv.axis = .vertical
        sv.spacing = 26
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activateTapGesture()
    }
    
    override func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(wholeStackView)
        view.addSubview(textView)
        view.addSubview(button)
        view.addSubview(imageUploadContainer)
        
        imageUploadContainer.isHidden = viewModel?.missionInfo.isAbleImg == 0
        
        wholeStackView.anchor(
            .top(view.topAnchor, constant: 80),
            .leading(view.leadingAnchor, constant: 40),
            .trailing(view.trailingAnchor, constant: 40))
            
        textView.anchor(.top(textfieldContainer.topAnchor, constant: 19),
                                  .leading(textfieldContainer.leadingAnchor, constant: 24),
                                  .trailing(textfieldContainer.trailingAnchor, constant: 24),
                                  .bottom(textfieldContainer.bottomAnchor, constant: 19))
        
        button.anchor(.bottom(bottomAnchor))
        button.centerXTo(view.centerXAnchor)
        
        imageUploadContainer.anchor(
            .leading(wholeStackView.leadingAnchor),
            .top(wholeStackView.bottomAnchor, constant: 15),
            .trailing(wholeStackView.trailingAnchor))
        imageUploadContainer.withHeight(67)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textfieldContainer.roundedBorder(corners: .allCorners, radius: 10)
    }
}

extension MissionPostViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionPostViewModel) {
        titleLabel.text = viewModel.missionName
        subtitleLabel.text = viewModel.missionDescription
        button.rx.action = viewModel.missionPreviewAction()
        
        imageUploadContainer.rx.tapGesture().bind {[unowned self] _ in
            let pickerController = UIImagePickerController()
            pickerController.sourceType = .photoLibrary
            pickerController.delegate = self
            self.navigationController?.present(pickerController, animated: true, completion: {
                
            })
        }
    }
}

extension MissionPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if
            let image = info[.originalImage] as? UIImage,
            let path = info[.referenceURL] as? URL
        {
            self.viewModel?.imageData = UploadableImage(fileName: path, image: image)
            imageUploadContainer.updateLabels(imagePath: path.absoluteString)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

// Setup Placeholder
extension MissionPostViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            setupPlaceHolder()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setupPlaceHolder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textfieldContainer.updateLabel(count: textView.text.count)
        button.isEnabled = !(textView.text.count == 0 || textView.text == placeholder)
        viewModel?.missionSendingData.content = textView.text
    }
    
    fileprivate func setupPlaceHolder() {
        if textView.text == placeholder {
            textView.text = ""
            textView.textColor = .black
        } else if textView.text == "" {
            textView.text = placeholder
            textView.textColor = .lightGray
        }
    }
}
