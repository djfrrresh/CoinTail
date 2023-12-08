//
//  UIWindow.swift
//  CoinTail
//
//  Created by Eugene on 06.12.23.
//

import UIKit


func topWindow() -> UIWindow? {
    return UIApplication.shared.connectedScenes.flatMap({ ($0 as? UIWindowScene)?.windows ?? [] }).first
}
