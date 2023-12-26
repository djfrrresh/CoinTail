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
        
        Currencies.shared.createDefaultFavouriteCurrenciesIfNeeded()
        KeychainManager.shared.saveAPIKeyToKeychain()
        RealmService.shared.readAllClasses()
        ExchangeRateManager.shared.getExchangeRates {}
        //TODO: переместить функции, используемые после выхода с экрана, на viewDidDisappear
        //TODO: переписать код для ячеек коллекций, сделать отдельные ячейки везде
        
        return true
    }

}
