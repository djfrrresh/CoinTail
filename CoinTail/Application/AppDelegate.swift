//
//  AppDelegate.swift
//  CoinTail
//
//  Created by Eugene on 16.05.23.
//

import UIKit
import CoreData


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? // Окно приложения, координирует представление изображения
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = TabBar() // Корневой контроллер
        window?.makeKeyAndVisible() // Отображение окна
        
        return true
    }

    // MARK: - Core Data stack
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSPersistentContainer(name: "CoinTail")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
    // MARK: - Core Data Saving support
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}
