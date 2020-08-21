//
//  InputController.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import UIKit

class InputController: UIViewController {

    private let margin: CGFloat = 8

    private let keywordTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "欲搜尋內容"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let perPageTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "每頁呈現數量"
        textField.font = .systemFont(ofSize: 14)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("搜尋", for: .normal)
        button.setTitleColor(.buttonTextWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = .enableButtonBgBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


private extension InputController {
    func setupView() {
        title = "搜尋輸入頁"
        view.backgroundColor = .white
        view.addSubview(keywordTextField)
        view.addSubview(perPageTextField)
        view.addSubview(searchButton)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // keyword text field
            keywordTextField.widthAnchor.constraint(equalTo: safeArea.widthAnchor,
                                                    constant: -40),
            keywordTextField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            keywordTextField.heightAnchor.constraint(equalToConstant: 30),
            keywordTextField.bottomAnchor.constraint(equalTo: perPageTextField.topAnchor,
                                                     constant: -margin),
            // per-page text field
            perPageTextField.widthAnchor.constraint(equalTo: keywordTextField.widthAnchor),
            perPageTextField.heightAnchor.constraint(equalTo: keywordTextField.heightAnchor),
            perPageTextField.centerXAnchor.constraint(equalTo: keywordTextField.centerXAnchor),
            perPageTextField.bottomAnchor.constraint(equalTo: searchButton.topAnchor,
                                                     constant: -margin),
            // search button
            searchButton.widthAnchor.constraint(equalTo: keywordTextField.widthAnchor),
            searchButton.heightAnchor.constraint(equalTo: keywordTextField.heightAnchor),
            searchButton.centerXAnchor.constraint(equalTo: keywordTextField.centerXAnchor),
            searchButton.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
        keywordTextField.layer.borderWidth = 1
        perPageTextField.layer.borderWidth = 1
        keywordTextField.layer.borderColor = UIColor.borderGray.cgColor
        perPageTextField.layer.borderColor = UIColor.borderGray.cgColor
        keywordTextField.layer.cornerRadius = 2
        perPageTextField.layer.cornerRadius = 2
    }
}
