//
//  PhotoListViewModel.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/23.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotoListViewModel: ViewModel {
    var titleText: String? { get }
    var numberOfSection: Int { get }
    func getResult() -> Observable<Void>
    func numberOfItems(in section: Int) -> Int
    func loadMoreIfNeeded(at index: Int) -> Observable<Void>
    func cellReuseId(in section: Int) -> String
    func cellViewModel(at indexPath: IndexPath) -> PhotoCellViewModel?
}
