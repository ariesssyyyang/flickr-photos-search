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

    var imageURL: URL? {
        URL(string: "https://farm\(model.farm).staticflickr.com/\(model.server)/\(model.id)_\(model.secret)_q.jpg")
    }

    init(model: Photo) {
        self.model = model
    }
}
