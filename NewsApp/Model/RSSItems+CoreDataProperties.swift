//
//  RSSItems+CoreDataProperties.swift
//  NewsApp
//
//  Created by Слава Васильев on 26.06.2024.
//
//

import Foundation
import CoreData

@objc(RSSItems)
public class RSSItems: NSManagedObject {}

extension RSSItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RSSItems> {
        return NSFetchRequest<RSSItems>(entityName: "RSSItems")
    }

    @NSManaged public var rssLink: String?
    @NSManaged public var rssResource: String?
    @NSManaged public var rssImage: String?
    @NSManaged public var rsspubData: Date?
    @NSManaged public var rssDescription: String?
    @NSManaged public var rssTitle: String?

}

extension RSSItems : Identifiable {}
