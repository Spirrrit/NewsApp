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

struct TransformeString {
    static func transformationString(_ str: String) -> String{
        return str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: "&laquo;", with: "«").replacingOccurrences(of: "&raquo;", with: "»").replacingOccurrences(of: "&nbsp;", with: " ").replacingOccurrences(of: "<p>", with: "\n").replacingOccurrences(of: "</p>", with: "\n").replacingOccurrences(of: "&mdash;", with: " — ").replacingOccurrences(of: "&ndash;", with: " — ").replacingOccurrences(of: "&lt;", with: "<").replacingOccurrences(of: "&gt;", with: ">").replacingOccurrences(of: "&hellip;", with: "...").replacingOccurrences(of: "&euro;", with: "€").replacingOccurrences(of: "//", with: ".").replacingOccurrences(of: "&#34;", with: "'")
    }
}
extension Date {
    var toRusString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("E, dd MMMM HH:mm")
        return dateFormatter.string(from: self)
    }
}

struct SupportFunc {
    static func getImage(str: String) -> UIImage? {
        guard let url = URL(string: str) else { return UIImage(named: "") }
        if let data = try? Data(contentsOf: url){
            return UIImage(data: data)
        } 
        return UIImage(named: "")
    }
    
    static func strToDate(_ stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MM yyyy HH:mm:ss Z"
        return dateFormatter.date(from: stringDate) ?? Date()
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

