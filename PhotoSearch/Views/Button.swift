//
//  Button.swift
//  PhotoSearch
//
//  Created by Aries Yang on 2020/8/22.
//  Copyright © 2020 Aries Yang. All rights reserved.
//

import Foundation
import UIKit

class Button: UIButton {

    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .buttonBackgroundBlue : .buttonBackgroundGray
        }
    }
}
