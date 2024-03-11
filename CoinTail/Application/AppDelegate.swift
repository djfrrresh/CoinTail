//
//  AppDelegate.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//
// The MIT License (MIT)
// Copyright © 2023 Eugeny Kunavin (kunavinjenya55@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit
import RevenueCat


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //TODO: переместить функции, используемые после выхода с экрана, на viewDidDisappear
    //TODO: переписать код для ячеек коллекций, сделать отдельные ячейки везде
    
    var window: UIWindow? // Окно приложения, координирует представление изображения
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = TabBar() // Корневой контроллер
        window?.makeKeyAndVisible() // Отображение окна
        
        // Сбросить значок уведомлений
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        _ = RevenueCatService.shared
        _ = SentryManager.shared
        
        Purchases.shared.delegate = self
        
        KeychainManager.shared.saveAPIKeyToKeychain() // Сохранение API ключа для конвертаций
        RealmService.shared.readAllClasses() // Читаем все Realm-классы
        ExchangeRateManager.shared.getExchangeRates {} // Получение обменных курсов валют
        Currencies.shared.createDefaultFavouriteCurrenciesIfNeeded() // Создание дефолтной валюты - USD
        Categories.shared.createDefaultCategoriesIfNeeded() // Создание дефолтных категорий трат и начислений
        AppSettings.shared.setPremiumUnactive() // Проверка на наличие премиум-подписки
        
        return true
    }

}
