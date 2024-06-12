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
