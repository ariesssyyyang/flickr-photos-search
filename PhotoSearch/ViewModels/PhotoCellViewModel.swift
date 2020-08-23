//
//  PhotoCellViewModel.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation

struct PhotoCellViewModel: ViewModel {

    private let model: Feed

    private weak var delegate: PhotoCellDelegate?

    let titleText: String

    let imageURL: URL?

    var shouldShowAddButton: Bool { model is Photo }

    init(model: Feed, delegate: PhotoCellDelegate?) {
        self.model = model
        self.delegate = delegate
        self.titleText = model.title
        self.imageURL = URL(string: model.urlString)
    }

    func addButtonDidTapped() {
        delegate?.addToFavorite(feed: model)
    }
}
