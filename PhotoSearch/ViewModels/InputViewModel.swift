//
//  InputViewModel.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct InputViewModel {

    func isValid(keyword: ControlProperty<String?>,
                 perPage: ControlProperty<String?>) -> Observable<Bool> {
        Observable
            .combineLatest(keyword.orEmpty, perPage.orEmpty)
            .map { !($0.0.isEmpty || $0.1.isEmpty) }
    }
}
