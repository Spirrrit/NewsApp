//
//  ViewController.swift
//  NewsApp
//
//  Created by Слава Васильев on 05.06.2024.
//

import UIKit

class MainViewController: UIViewController {

    private var rssItems: [RSSItem]?
    let tableView: UITableView = .init()
    
    //MARK: - Lifi cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Главная"
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        fetchData()
    }
    
    //MARK: - Load Data
    // попробовать вынести функцию в ViewModel ???
    
    private func fetchData() {
        let feedParser = FeedParser()
        let queue = DispatchQueue(label: "Load News", attributes: .concurrent)
    
        queue.async {
            feedParser.parseFeed(url: "https://rssexport.rbc.ru/rbcnews/news/30/full.rss", resource: .rbk) { (rssItem) in
                self.rssItems = rssItem
                OperationQueue.main.addOperation {
                    self.rssItems?.sort(by: { $0.pubData  > $1.pubData })
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
            }
        }
        queue.async {
            feedParser.parseFeed(url: "https://news.rambler.ru/rss/world/", resource: .rambler) { (rssItem) in
                self.rssItems = rssItem
                OperationQueue.main.addOperation {
                    self.rssItems?.sort(by: { $0.pubData  > $1.pubData })
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
            }
        }
        queue.async {
            feedParser.parseFeed(url: "https://www.mk.ru/rss/index.xml", resource: .mk) { (rssItem) in
                self.rssItems = rssItem
                OperationQueue.main.addOperation {
                    
                    self.rssItems?.sort(by: { $0.pubData  > $1.pubData })
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
            }
        }
        queue.async {
            feedParser.parseFeed(url: "https://www.kommersant.ru/RSS/news.xml", resource: .komersant) { (rssItem) in
                self.rssItems = rssItem
                OperationQueue.main.addOperation {
                    self.rssItems?.sort(by: { $0.pubData  > $1.pubData })
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
            }
        }
        queue.async {
            feedParser.parseFeed(url: "https://ria.ru/export/rss2/archive/index.xml", resource: .ria) { (rssItem) in
                self.rssItems = rssItem
                OperationQueue.main.addOperation {
                    self.rssItems?.sort(by: { $0.pubData  > $1.pubData })
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
            }
        }
    }
}

//MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detail = rssItems?[indexPath.item] {
                navigationController?.pushViewController(DetailViewController(with: detail), animated: true)
        }
    }
}

//MARK: - TableView DataSourse
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { fatalError("Non cell") }
        
        if let item = rssItems?[indexPath.item] {
            cell.configure(cellSource: item)
        }
        return cell
    }
}

//MARK: - Extensions
extension MainViewController {
    func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
