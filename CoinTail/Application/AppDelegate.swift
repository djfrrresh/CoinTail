//
//  AppDelegate.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? // Окно приложения, координирует представление изображения
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = TabBar() // Корневой контроллер
        window?.makeKeyAndVisible() // Отображение окна
        
        RealmService.shared.readAllClasses()
        //TODO: прила вылетает после удаления всех данных и захода на экран добавления операции
        
        return true
    }

}
