//
//  Photo.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation

struct Photo: Feed, Decodable {
    let id: String
    let farm: Int
    let server: String
    let secret: String
    let title: String

    var urlString: String {
        "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_q.jpg"
    }
}

struct PhotoList: Decodable {
    let page: Int
    let pages: Int
    let photos: [Photo]

    enum ContainerCodingKeys: CodingKey {
        case photos
    }

    enum CodingKeys: String, CodingKey {
        case page, pages
        case photos = "photo"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: ContainerCodingKeys.self)
            .nestedContainer(keyedBy: CodingKeys.self, forKey: .photos)
        self.page = try container.decode(Int.self, forKey: .page)
        self.pages = try container.decode(Int.self, forKey: .pages)
        self.photos = try container.decode([Photo].self, forKey: .photos)
    }
}
