//
//  FavoriteListViewModel.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/23.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import RxSwift

class FavoriteListViewModel: PhotoListViewModel {

    private var favorites: [Favorite]

    var titleText: String? { "我的最愛" }

    var numberOfSection: Int { 1 }

    init() {
        self.favorites = []
    }

    func getFeeds() -> Observable<Void> {
        return LocalStore.shared.getFavoriteList()
            .map { [weak self] in self?.favorites = $0 }
    }

    func numberOfItems(in section: Int) -> Int {
        favorites.count
    }

    func loadMoreIfNeeded(at index: Int) -> Observable<Void> {
        return Observable.never()
    }

    func cellReuseId(in section: Int) -> String {
        return PhotoCell.reuseId
    }

    func cellViewModel(at indexPath: IndexPath) -> PhotoCellViewModel? {
        guard indexPath.item < favorites.count else { return nil }
        return PhotoCellViewModel(model: favorites[indexPath.item], delegate: nil)
    }
}
