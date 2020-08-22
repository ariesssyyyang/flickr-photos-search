//
//  ResultListViewModel.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation

struct ResultListViewModel {

    let keyword: String
    private let perPage: String

    private(set) var results: [Photo]

    init(keyword: String, perPage: String) {
        self.keyword = keyword
        self.perPage = perPage
        self.results = [
            Photo(id: "", farmId: "", serverId: "", secret: "", title: "hi"),
            Photo(id: "", farmId: "", serverId: "", secret: "", title: "ya"),
            Photo(id: "", farmId: "", serverId: "", secret: "", title: "boo")
        ]
    }

    func cellViewModel(at index: Int) -> ViewModel? {
        guard index < results.count else { return nil }
        return PhotoCellViewModel(model: results[index])
    }
}
