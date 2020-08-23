//
//  InputController.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class InputController: UIViewController {

    private let viewModel = InputViewModel()

    private let bag = DisposeBag()

    private let keywordTextField: TextField = {
        let textField = TextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "欲搜尋內容", attributes: [.foregroundColor: UIColor.textGray]
        )
        textField.textColor = .textBlack
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let perPageTextField: TextField = {
        let textField = TextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "每頁呈現數量", attributes: [.foregroundColor: UIColor.textGray]
        )
        textField.textColor = .textBlack
        textField.font = .systemFont(ofSize: 14)
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let searchButton: Button = {
        let button = Button()
        button.setTitle("搜尋", for: .normal)
        button.setTitleColor(.buttonTextWhite, for: .normal)
        button.setTitleColor(.buttonTextGray, for: .disabled)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

private extension InputController {

    func bindViewModel() {
        viewModel.isValid(keyword: keywordTextField.rx.text,
                          perPage: perPageTextField.rx.text)
            .bind(to: searchButton.rx.isEnabled)
            .disposed(by: bag)

        searchButton.rx.tap
            .subscribe(onNext: showResult)
            .disposed(by: bag)
    }

    func showResult(_ event: ControlEvent<Void>.Element) {
        guard
            let keyword = keywordTextField.text,
            let perPage = perPageTextField.text
            else {
                assertionFailure("Button's action should only triggered when there's input.")
                return
        }
        let viewModel = ResultListViewModel(keyword: keyword, perPage: perPage)
        let controller = ResultListController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }

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
                                                     constant: -LINE_SPACING),
            // per-page text field
            perPageTextField.widthAnchor.constraint(equalTo: keywordTextField.widthAnchor),
            perPageTextField.heightAnchor.constraint(equalTo: keywordTextField.heightAnchor),
            perPageTextField.centerXAnchor.constraint(equalTo: keywordTextField.centerXAnchor),
            perPageTextField.bottomAnchor.constraint(equalTo: searchButton.topAnchor,
                                                     constant: -LINE_SPACING),
            // search button
            searchButton.widthAnchor.constraint(equalTo: keywordTextField.widthAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.centerXAnchor.constraint(equalTo: keywordTextField.centerXAnchor),
            searchButton.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
        keywordTextField.layer.borderWidth = 1
        perPageTextField.layer.borderWidth = 1
        keywordTextField.layer.borderColor = UIColor.borderGray.cgColor
        perPageTextField.layer.borderColor = UIColor.borderGray.cgColor
        keywordTextField.layer.cornerRadius = 2
        perPageTextField.layer.cornerRadius = 2
        searchButton.layer.cornerRadius = 10
    }
}
