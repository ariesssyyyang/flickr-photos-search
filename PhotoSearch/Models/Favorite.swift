//
//  Favorite.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/23.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import CoreData

struct Favorite: Feed {
    let title: String
    let urlString: String

    init?(_ object: NSManagedObject) {
        guard
        let title = object.value(forKey: "title") as? String,
        let urlString = object.value(forKey: "image") as? String
        else { return nil }
        self.title = title
        self.urlString = urlString
    }
}
