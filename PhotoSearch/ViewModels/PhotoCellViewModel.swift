//
//  PhotoCellViewModel.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation

struct PhotoCellViewModel: ViewModel {

    private let model: Photo

    var titleText: String { model.title }

    init(model: Photo) {
        self.model = model
    }
}
