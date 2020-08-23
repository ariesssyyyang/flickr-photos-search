//
//  LocalStore.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/23.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

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

    func addToFavorite(feed: Feed) -> Observable<Bool> {
        Observable.create { [unowned self] (observer) -> Disposable in
            let managedContext = self.persistentContainer.viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: "FavoritePhoto", in: managedContext) else {
                observer.onError(LocalStoreError.entityNotFound)
                return Disposables.create { }
            }
            let favorite = NSManagedObject(entity: entity, insertInto: managedContext)
            favorite.setValue(feed.title, forKey: "title")
            favorite.setValue(feed.urlString, forKey: "image")
            do {
                try managedContext.save()
                observer.onNext(true)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create { }
        }
    }

    func getFavoriteList() -> Observable<[Favorite]> {
        Observable.create { (observer) -> Disposable in
            let managedContext = self.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritePhoto")
            do {
                let favorites = try managedContext.fetch(fetchRequest).compactMap { Favorite($0) }
                observer.onNext(favorites)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create { }
        }
    }
}
