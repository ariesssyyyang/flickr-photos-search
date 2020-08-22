//
//  PhotoCell.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {

    static let LABEL_HEIGHT: CGFloat = 20

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

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupView()
    }
}

extension PhotoCell: Configurable {
    func configure(_ viewModel: ViewModel?) {
        guard let viewModel = viewModel as? PhotoCellViewModel else {
            assertionFailure("Expected to be PhotoCellViewModel.")
            return
        }
        titleLabel.text = viewModel.titleText
        photoView.kf.setImage(with: viewModel.imageURL)
    }
}

private extension PhotoCell {
    func setupView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(photoView)
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
            titleLabel.heightAnchor.constraint(equalToConstant: PhotoCell.LABEL_HEIGHT)
        ])
    }
}
