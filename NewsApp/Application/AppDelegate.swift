//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Слава Васильев on 05.06.2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
        
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (discription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            } else {
            
                print("DB urls -", discription.url?.absoluteString)
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError(error.localizedDescription)
            }
        }
    }

}

