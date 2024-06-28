//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Слава Васильев on 26.06.2024.
//

import UIKit
import CoreData

//MARK: - CRUD

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init (){}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - Create
    public func createRssItems(title: String,discription: String, date: Date, image: String, resource: String, link: String ) {
        guard let rssItemEntityDiscription = NSEntityDescription.entity(forEntityName: "RSSItems", in: context) else { return print("Failed to create a description")}
        let rssItems = RSSItems(entity: rssItemEntityDiscription, insertInto: context)
        rssItems.rssTitle = title
        rssItems.rssDescription = discription
        rssItems.rssPubData = date
        rssItems.rssImage = image
        rssItems.rssResource = resource
        rssItems.rssLink = link
        appDelegate.saveContext()
    }
    //MARK: - Read
    public func fetchRssItems() -> [RSSItems] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RSSItems")
        do {
            return try context.fetch(fetchRequest) as! [RSSItems]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    //MARK: - Update
    public func updateRssItems(_ title: String, _ discription: String, _ date: Date,_ image: String,_ resource: String, _ link: String ){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RSSItems")
        do {
            guard let rssItems = try? context.fetch(fetchRequest) as? [RSSItems],
                  let rssItem = rssItems.first(where: { $0.rssTitle == title }) else { return }
            
            rssItem.rssTitle = title
            rssItem.rssDescription = discription
            rssItem.rssPubData = date
            rssItem.rssImage = image
            rssItem.rssResource = resource
            rssItem.rssLink = link
        }
        appDelegate.saveContext()
    }
    
//    public func updateAllRssItems(_ title: String, _ discription: String, _ date: Date,_ image: String,_ resource: String, _ link: String ){
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RSSItems")
//        do {
//            let rssItems = try? context.fetch(fetchRequest) as? [RSSItems]
//
//        }
//        appDelegate.saveContext()
//    }
    
    //MARK: -  Deleta
    public func deletaAllRssItems() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RSSItems")
        do {
            let rssItems = try? context.fetch(fetchRequest) as? [RSSItems]
            rssItems?.forEach { context.delete($0)}
        }
        appDelegate.saveContext()

    }
    
}
