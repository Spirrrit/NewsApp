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
    private var rssItemsCoreData: [RSSItems] = []
    private var currentElement: String = ""
    private var currentImage: UIImage?
    private var currentResource: String = ""
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = TransformeString.transformationString(currentTitle)
        }
    }
    private var currentDescription: String = "" {
        didSet {
            currentDescription = TransformeString.transformationString(currentDescription)
        }
    }
    private var currentpubDate: String = "" {
        didSet {
            currentpubDate = currentpubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentImageLink: String = "" {
        didSet {
            currentImageLink = currentImageLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentLink: String = "" {
        didSet {
            currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }

    func parseFeed(url: String, resource: SourceNews , completionHandler:(([RSSItem]) -> Void)?){
        
        self.parserCompletionHandler = completionHandler

            let request = URLRequest(url: URL(string: url)!)
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
                self.currentResource = resource.rawValue
                parser.parse()
            }
            task.resume()
    }
    
    //MARK: - Auxiliary Functions
    func getImage(str: String) -> UIImage? {
        let url = URL(string: str)
        if let data = try? Data(contentsOf: url!){
            return UIImage(data: data)
        }
        return UIImage(named: "icon")
    }
    
    func strToDate(_ stringDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MM yyyy HH:mm:ss Z"
        return dateFormatter.date(from: stringDate)
    }
    
    //MARK: - Parser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentpubDate = ""
            currentLink = ""
            currentImage = UIImage(named: "icon")
            currentImageLink = ""
        }
        
        if currentElement == "enclosure" {
            let attrsUrl = attributeDict as [String: NSString]
            let urlPic = attrsUrl["url"]
            currentImageLink = urlPic! as String
            currentImage = getImage(str: urlPic! as String)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentDescription += string
        case "rbc_news:full-text": currentDescription += string
        case "link": currentLink += string
        case "pubDate": currentpubDate += string
        case "rbc_news:url": currentImage = getImage(str: string) ?? UIImage(named: "icon")
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubData: strToDate(currentpubDate) ?? Date(), image: currentImage, resource: currentResource, link: currentLink)
            
            // Запись в CodeData
            
//            CoreDataManager.shared.createRssItems(title: currentTitle, discription: currentDescription, date: strToDate(currentpubDate) ?? Date(), image: currentImage, resource: currentResource, link: currentLink)
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
