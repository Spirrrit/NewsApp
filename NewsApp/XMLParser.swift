//
//  XMLParser.swift
//  NewsApp
//
//  Created by Слава Васильев on 06.06.2024.
//

import Foundation
import UIKit

struct RSSItem {
    var title: String
    var description: String
    var pubData: String
    var image: UIImage?
    var resource: String
}
enum SourceNews: String {
    case rbk = "РБК"
    case rambler = "Рамблер"
    case lenta = "Лента.ру"
    case none = "Ресурс"
}

func getImage(str: String) -> UIImage? {
    let url = URL(string: str)
    if let data = try? Data(contentsOf: url!){
        return UIImage(data: data)
    }
    return UIImage(systemName: "questionmark")
}

class FeedParser: NSObject, XMLParserDelegate {
    private var rssItems: [RSSItem] = []
    private var currentElement: String = ""
    private var currentImage: UIImage?
    private var sourceNews: String = ""
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentpubDate: String = "" {
        didSet {
            currentpubDate = currentpubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentResource: String = "" {
        didSet {
            currentResource = currentResource.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
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
    
    //MARK: - Parser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentpubDate = ""
            currentResource = ""
            currentImage = nil
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescription += string
        case "rbc_news:full-text": currentDescription += string
        case "pubDate": currentpubDate += string
        case "rbc_news:url": currentImage = getImage(str: string) ?? nil
        default: break
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubData: currentpubDate, image: currentImage, resource: sourceNews)
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
