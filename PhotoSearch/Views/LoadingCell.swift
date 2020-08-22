//
//  LoadingCell.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let indicator = UIActivityIndicatorView(style: .gray)
        contentView.addSubview(indicator)
        indicator.center = contentView.center
        indicator.startAnimating()
    }
}
