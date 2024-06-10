//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Слава Васильев on 05.06.2024.
//

import UIKit

class DetailViewController: UIViewController {

    lazy var titleNews: UILabel = {
       let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 30)
        lable.numberOfLines = 0
        lable.text  = ""
        return lable
    }()
    
    lazy var discriptionNews: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.numberOfLines = 0
        lable.text  = ""
        return lable
    }()
    
    lazy var dateNews: UILabel = {
       let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.textColor = .lightGray
        lable.numberOfLines = 0
        lable.text  = ""
        return lable
    }()
    
    lazy var imageNews: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    private lazy var scrollView = UIScrollView()
    
    
    init(with source: RSSItem){
        super.init(nibName: nil, bundle: nil)
        titleNews.text = source.title
        imageNews.image = source.image
        discriptionNews.text = source.description
        dateNews.text = source.pubData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        [titleNews, imageNews, dateNews, discriptionNews].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleNews.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleNews.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleNews.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            titleNews.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageNews.topAnchor.constraint(equalTo: titleNews.bottomAnchor, constant: 20),
            imageNews.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageNews.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageNews.heightAnchor.constraint(equalToConstant: 200),
            imageNews.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            dateNews.topAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: 20),
            dateNews.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            dateNews.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            dateNews.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            discriptionNews.topAnchor.constraint(equalTo: dateNews.bottomAnchor, constant: 20),
            discriptionNews.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            discriptionNews.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            discriptionNews.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            discriptionNews.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
        ])
        
        
    }
    


}
