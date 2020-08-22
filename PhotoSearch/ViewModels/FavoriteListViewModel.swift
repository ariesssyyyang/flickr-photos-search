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

    var titleText: String? { "我的最愛" }

    var numberOfSection: Int { 1 }

    func getResult() -> Observable<Void> {
        return Observable.just(())
    }

    func numberOfItems(in section: Int) -> Int {
        0
    }

    func loadMoreIfNeeded(at index: Int) -> Observable<Void> {
        return Observable.never()
    }

    func cellReuseId(in section: Int) -> String {
        return ""
    }

    func cellViewModel(at indexPath: IndexPath) -> PhotoCellViewModel? {
        return nil
    }
}
