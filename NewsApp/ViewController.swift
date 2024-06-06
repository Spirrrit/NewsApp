//
//  ViewController.swift
//  NewsApp
//
//  Created by Слава Васильев on 05.06.2024.
//

import UIKit

class ViewController: UIViewController {

//    var resources = Resource.makeSource()
    private var rssItems: [RSSItem]?
    
    let tableView: UITableView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        title = "Главная"
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
        
        fetchData()
        
    }

    private func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://rssexport.rbc.ru/rbcnews/news/30/full.rss") { (rssItem) in
            self.rssItems = rssItem
            
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }

}

extension ViewController {
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

//MARK: - TableView Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detail = rssItems?[indexPath.item] {
            navigationController?.pushViewController(DetailViewController(with: detail), animated: true)
        }
        
        
    }
}

//MARK: - TableView DataSourse
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        resources.count
        guard let rssItems = rssItems else {
            return 0
        }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { fatalError("Non cell") }
        
        //        cell.configure(cellSource: rssItems[indexPath.row])
        if let item = rssItems?[indexPath.item] {
            cell.configure(cellSource: item)
        }
        return cell
        
        
    }
}

