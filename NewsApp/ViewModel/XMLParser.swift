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
    private var currentResource: String = ""
    
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            currentTitle = currentTitle.replacingOccurrences(of: "//", with: ".")
            currentTitle = currentTitle.replacingOccurrences(of: "&#34;", with: "'")
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
        }
    }
    
    
    private var currentLink: String = "" {
        didSet {
            currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    
    
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseFeed(url: String, resource: SourceNews , completionHandler:(([RSSItem]) -> Void)?){
        
        self.parserCompletionHandler = completionHandler
        self.currentResource = resource.rawValue
        
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
            
        }
        
        if currentElement == "enclosure" {
            let attrsUrl = attributeDict as [String: NSString]
            let urlPic = attrsUrl["url"]
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
