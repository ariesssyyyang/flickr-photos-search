//
//  PhotoCell.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

protocol PhotoCellDelegate: AnyObject {
    func addToFavorite(feed: Feed)
}

class PhotoCell: UICollectionViewCell {

    static let LABEL_HEIGHT: CGFloat = 20

    private var bag = DisposeBag()

    private let photoView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textBlack
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let addButton: UIButton = {
        let button = Button()
        button.setTitle("➕", for: .normal)
        button.backgroundColor = .buttonBackgroundGray
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = .init()
    }
}

extension PhotoCell: Configurable {
    func configure(_ viewModel: ViewModel?) {
        guard let viewModel = viewModel as? PhotoCellViewModel else { return }
        titleLabel.text = viewModel.titleText
        photoView.kf.setImage(with: viewModel.imageURL)
        addButton.rx.tap
            .subscribe(onNext: viewModel.addButtonDidTapped)
            .disposed(by: bag)
        addButton.isHidden = !viewModel.shouldShowAddButton
    }
}

private extension PhotoCell {
    func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(photoView)
        contentView.addSubview(addButton)
        NSLayoutConstraint.activate([
            // photo image view
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            // title label
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: photoView.bottomAnchor,
                                            constant: MARGIN),
            titleLabel.heightAnchor.constraint(equalToConstant: PhotoCell.LABEL_HEIGHT),
            // add to favorite button
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.topAnchor.constraint(equalTo: photoView.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: photoView.trailingAnchor)
        ])
    }
}
