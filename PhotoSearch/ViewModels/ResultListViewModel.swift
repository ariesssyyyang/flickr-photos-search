//
//  ResultListViewModel.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import RxSwift

class ResultListViewModel: PhotoListViewModel {

    private let keyword: String
    private let perPage: String
    private var page: Int
    private var totalPages: Int
    private var results: [Photo]

    var titleText: String? { "搜尋結果 " + keyword }
    private(set) var numberOfSection: Int = 2 /* data + loading */

    init(keyword: String, perPage: String) {
        self.keyword = keyword
        self.perPage = perPage
        self.totalPages = 0
        self.results = []
        self.page = 0
    }

    func getFeeds() -> Observable<Void> {
        results = []
        page = 0
        numberOfSection = 2
        return requestData()
    }

    func numberOfItems(in section: Int) -> Int {
        section == 0 ? results.count : 1
    }

    func loadMoreIfNeeded(at index: Int) -> Observable<Void> {
        if shouldLoadMore(at: index) { return requestData() }
        return Observable.never()
    }

    func cellReuseId(in section: Int) -> String {
        section == 0 ? PhotoCell.reuseId : LoadingCell.reuseId
    }

    func cellViewModel(at indexPath: IndexPath) -> PhotoCellViewModel? {
        guard indexPath.section == 0, indexPath.item < results.count else { return nil }
        return PhotoCellViewModel(model: results[indexPath.item], delegate: self)
    }
}

extension ResultListViewModel: PhotoCellDelegate {

    func addToFavorite(feed: Feed) {
        _ = LocalStore.shared.addToFavorite(feed: feed).subscribe(onNext: { _ in })
    }
}

private extension ResultListViewModel {

    func shouldLoadMore(at index: Int) -> Bool {
        index == results.count - 1 && page < totalPages
    }

    func requestData() -> Observable<Void> {
        ApiManager.shared
            .searchPhotos(by: keyword, perPage: perPage, page: page + 1)
            .map { try JSONDecoder().decode(PhotoList.self, from: $0) }
            .map { [weak self] in self?.configure($0) }
    }

    func configure(_ model: PhotoList) {
        self.results.append(contentsOf: model.photos)
        self.page = model.page
        self.totalPages = model.pages
        if page == totalPages { numberOfSection = 1 }
    }
}
