//
//  ViewController.swift
//  NewsApp
//
//  Created by Слава Васильев on 05.06.2024.
//

import UIKit

class MainVC: UIViewController {

    private var rssItems: [RSSItem]?
    private var rssItemsForCoreData: [RSSItems]?
    let tableView: UITableView = .init()
    let refreshControlData = UIRefreshControl()
    
    //MARK: - Lifi cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Главная"
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControlData
        
        
        setupTableView()
        fetchData()
        coreDataLoad()
        

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(removeData))
        refreshControlData.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshControlData.beginRefreshingManually()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.refreshControlData.endRefreshing()
        }
        
    }
    
    //MARK: - @objc funcs
    
    @objc  func refreshData(sender: UIRefreshControl) {
//        fetchData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.refreshControlData.endRefreshing()
        }
    }
    
    @objc func removeData() {
        CoreDataManager.shared.deletaAllRssItems()
        rssItems?.removeAll()
        self.tableView.reloadData()
    }
    
    private func coreDataLoad(){
        let queue = DispatchQueue(label: "CoreDataLoad", attributes: .concurrent)
        queue.async { [self] in
            self.rssItemsForCoreData = CoreDataManager.shared.fetchRssItems()
        }
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
extension MainVC: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let detail = rssItems?[indexPath.item] {
                    navigationController?.pushViewController(DetailVC(with: detail), animated: true)
            } else {
                if let detailCore = rssItemsForCoreData?[indexPath.item] {
                        navigationController?.pushViewController(DetailVC(withCoreData: detailCore), animated: true)
                }
            }
        }
    
    // CoreData
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let detail = rssItemsForCoreData?[indexPath.item] {
//            navigationController?.pushViewController(DetailViewController(with: detail), animated: true)
//        }
//    }
}
    
    //MARK: - TableView DataSourse
    
    // CoreData
    
//    extension MainViewController: UITableViewDataSource {
//        
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            guard let rssItemsForCoreDatas = rssItemsForCoreData else { return 0 }
//
//            return rssItemsForCoreDatas.count
//            
//        }
//        
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { fatalError("Non cell") }
//            
//            if let item = rssItemsForCoreData?[indexPath.item] {
//                cell.configureCoreDataCell(cellSource: item)
//            }
//            
//            return cell
//        }
//    }
    
    
extension MainVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let rssItems = rssItems else { return rssItemsForCoreData?.count ?? 0 }
//        return rssItems.count
        
        if let rssItems = rssItems {
            return rssItems.count
        } else {
            return rssItemsForCoreData?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else { fatalError("Non cell") }
        
        if let item = rssItems?[indexPath.item] {
            cell.configure(cellSource: item)
        } else {
            if let itemCore = rssItemsForCoreData?[indexPath.item]{
                
                rssItemsForCoreData?.sort(by: {$0.rssPubData > $1.rssPubData })
                cell.configureCoreDataCell(cellSource: itemCore)
            }
        }
        return cell
    }
}
    
    //MARK: - Extensions
    extension MainVC {
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

extension UIRefreshControl {
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
}
