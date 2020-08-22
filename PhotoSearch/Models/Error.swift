//
//  Error.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation

enum FlickrError: Error {
    case invalidURL(str: String?), networkError
}
