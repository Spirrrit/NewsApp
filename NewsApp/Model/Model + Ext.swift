//
//  Model.swift
//  NewsApp
//
//  Created by Слава Васильев on 11.06.2024.
//

import Foundation
import UIKit

struct RSSItem {
    var title: String
    var description: String
    var pubData: Date
    var image: UIImage?
    var resource: String
    var link: String
}
enum SourceNews: String {
    case rbk = "РБК"
    case rambler = "Рамблер"
    case mk = "Московский Комсомолец"
    case komersant = "Комерсант"
    case ria = "РИА Новости"
    case none = "Ресурс"
}

extension Date {
    var toRusString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("E, dd MMMM HH:mm")
        return dateFormatter.string(from: self)
    }
}

//struct NewsResource {
//    static func getSourceLink() -> [String]{
//        let links = [
////            "https://rssexport.rbc.ru/rbcnews/news/30/full.rss",
////            "https://news.rambler.ru/rss/world/",
////            "https://www.mk.ru/rss/index.xml",
//            "https://www.kommersant.ru/RSS/news.xml",
////            "https://ria.ru/export/rss2/archive/index.xml"
//        ]
//        return links
//    }
//}
