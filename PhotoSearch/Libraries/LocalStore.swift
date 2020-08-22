//
//  LocalStore.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/23.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import CoreData

class LocalStore {

    static let shared = LocalStore()

    private let persistentContainer: NSPersistentContainer

    private init() {
        let container = NSPersistentContainer(name: "PhotoSearch")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        self.persistentContainer = container
    }

    func configure() { }
}
