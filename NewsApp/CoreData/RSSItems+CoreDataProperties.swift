//
//  RSSItems+CoreDataProperties.swift
//  NewsApp
//
//  Created by Слава Васильев on 26.06.2024.
//
//

import Foundation
import CoreData
import UIKit

@objc(RSSItems)
public class RSSItems: NSManagedObject {}

extension RSSItems {
    @NSManaged public var rssLink: String?
    @NSManaged public var rssResource: String?
    @NSManaged public var rssImage: UIImage?
    @NSManaged public var rssPubData: Date
    @NSManaged public var rssDescription: String?
    @NSManaged public var rssTitle: String?
}

extension RSSItems : Identifiable {}
