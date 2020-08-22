//
//  ResultListViewModel.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import RxSwift

class ResultListViewModel {

    let keyword: String
    private let perPage: String

    private(set) var results: [Photo]

    init(keyword: String, perPage: String) {
        self.keyword = keyword
        self.perPage = perPage
        self.results = []
    }

    func getResult() -> Observable<Void> {
        ApiManager.shared
            .searchPhotos(by: keyword, perPage: perPage)
            .map { try JSONDecoder().decode(PhotoList.self, from: $0) }
            .map { [weak self] in self?.results = $0.photos }
    }

    func cellViewModel(at index: Int) -> ViewModel? {
        guard index < results.count else { return nil }
        return PhotoCellViewModel(model: results[index])
    }
}
