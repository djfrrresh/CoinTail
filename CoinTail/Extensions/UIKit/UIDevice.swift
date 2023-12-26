//
//  UIDevice.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit


extension UIDevice {
    
    var hasNotch: Bool {
        guard let window = topWindow(), window.isKeyWindow else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0 || window.safeAreaInsets.top >= 44
        } else {
            return window.safeAreaInsets.top >= 44
        }
    }
    
}
