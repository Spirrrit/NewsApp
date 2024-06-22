//
//  XMLParser.swift
//  NewsApp
//
//  Created by Слава Васильев on 06.06.2024.
//

import Foundation
import UIKit

class FeedParser: NSObject, XMLParserDelegate {
    private var rssItems: [RSSItem] = []
    private var currentElement: String = ""
    private var currentImage: UIImage?
    private var sourceNews: String = ""
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            currentTitle = currentTitle.replacingOccurrences(of: "//", with: ".")
        }
    }
    private var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            currentDescription = currentDescription.replacingOccurrences(of: "&laquo;", with: "«").replacingOccurrences(of: "&raquo;", with: "»")
            currentDescription = currentDescription.replacingOccurrences(of: "&nbsp;", with: " ")
            currentDescription = currentDescription.replacingOccurrences(of: "<p>", with: "\n").replacingOccurrences(of: "</p>", with: "\n")
            currentDescription = currentDescription.replacingOccurrences(of: "&mdash;", with: " — ").replacingOccurrences(of: "&ndash;", with: " — ")
            currentDescription = currentDescription.replacingOccurrences(of: "&lt;", with: "<").replacingOccurrences(of: "&gt;", with: ">").replacingOccurrences(of: "&hellip;", with: "...")
            currentDescription = currentDescription.replacingOccurrences(of: "&euro;", with: "€")
        }
    }
    private var currentpubDate: String = "" {
        didSet {
            currentpubDate = currentpubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            currentpubDate = currentpubDate.replacingOccurrences(of: "+0300", with: "")
            currentpubDate = currentpubDate.replacingOccurrences(of: "Mon", with: "Пон").replacingOccurrences(of: "Tue", with: "Вт").replacingOccurrences(of: "Wed", with: "Ср").replacingOccurrences(of: "Thu", with: "Чт").replacingOccurrences(of: "Fri", with: "Пт").replacingOccurrences(of: "Sat", with: "Сб").replacingOccurrences(of: "Sun", with: "Вс")
            currentpubDate = currentpubDate.replacingOccurrences(of: "Jan", with: "Янв").replacingOccurrences(of: "Feb", with: "Фев").replacingOccurrences(of: "Mar", with: "Мар").replacingOccurrences(of: "Apr", with: "Апр").replacingOccurrences(of: "May", with: "Мая").replacingOccurrences(of: "Jun", with: "Июн").replacingOccurrences(of: "Jul", with: "Июл").replacingOccurrences(of: "Aug", with: "Авг").replacingOccurrences(of: "Sep", with: "Сен").replacingOccurrences(of: "Oc", with: "Окт").replacingOccurrences(of: "No", with: "Нояб").replacingOccurrences(of: "De", with: "Дек")
            
            
        }
    }
    private var currentResource: String = "" {
        didSet {
            currentResource = currentResource.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentLink: String = ""
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseFeed(url: [String], resource: SourceNews , completionHandler:(([RSSItem]) -> Void)?){
        
        self.parserCompletionHandler = completionHandler
        self.sourceNews = resource.rawValue
        
        for i in url {
            let request = URLRequest(url: URL(string: i)!)
            let urlSession = URLSession.shared
            let task = urlSession.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    return
                }
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
            task.resume()
        }
    }
    
    func getImage(str: String) -> UIImage? {
        let url = URL(string: str)
        if let data = try? Data(contentsOf: url!){
            return UIImage(data: data)
        }
        return UIImage(named: "icon")
    }
    
    //MARK: - Parser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentpubDate = ""
            currentResource = ""
            currentImage = UIImage(named: "icon")
            currentLink = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescription += string
//        case "pdalink": currentLink += string
        case "link": currentLink += string
        case "rbc_news:full-text": currentDescription += string
        case "pubDate": currentpubDate += string
        case "rbc_news:url": currentImage = getImage(str: string) ?? UIImage(named: "icon")
        default: break
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubData: currentpubDate, image: currentImage, resource: sourceNews, link: currentLink)
            self.rssItems.append(rssItem)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: any Error) {
        print(parseError.localizedDescription)
    }
    
}
