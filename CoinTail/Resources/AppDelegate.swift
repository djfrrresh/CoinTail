//
//  AppDelegate.swift
//  CoinTail
//
//  Created by Eugene on 04.10.22.
//

import UIKit


@main // Главный класс, отсюда запускается приложение
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? // Окно приложения, координирует представление изображения
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = TabBarViewController() // Корневой контроллер
        window?.makeKeyAndVisible() // Отображение окна
        return true
    }
    
}

