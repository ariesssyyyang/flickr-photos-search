//
//  ApiManager.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import RxSwift

final class ApiManager {

    static let shared = ApiManager()

    private init() { }

    func searchPhotos(by keyword: String, perPage: String) -> Observable<Data> {
        Observable.create { observer -> Disposable in
            var component = URLComponents(string: "https://www.flickr.com/services/rest/")
            component?.queryItems = [
                URLQueryItem(name: "method", value: "flickr.photos.search"),
                URLQueryItem(name: "api_key", value: API_KEY),
                URLQueryItem(name: "format", value: "json"),
                URLQueryItem(name: "nojsoncallback", value: "1"),
                URLQueryItem(name: "text", value: keyword),
                URLQueryItem(name: "per_page", value: perPage)
            ]
            guard let url = component?.url else {
                observer.onError(FlickrError.invalidURL(str: component?.string))
                return Disposables.create { }
            }
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: request) { data, res, error in
                if let error = error { observer.onError(error) }
                if let statusCode = (res as? HTTPURLResponse)?.statusCode {
                    switch statusCode {
                    case 200...399:
                        guard let data = data else { fallthrough }
                        observer.onNext(data)
                        observer.onCompleted()
                    default:
                        observer.onError(FlickrError.networkError)
                    }
                }
            }
            dataTask.resume()
            return Disposables.create { dataTask.cancel() }
        }
    }
}
