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
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .boldSystemFont(ofSize: 32)
        lable.numberOfLines = 0
        lable.text  = ""
        return lable
    }()
    
    lazy var discriptionNews: UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.numberOfLines = 0
        lable.text  = ""
        return lable
    }()
    lazy var imageNews = UIImageView()
    
    
    init(with source: CellSource){
        super.init(nibName: nil, bundle: nil)
        discriptionNews.text = source.discription
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        view.addSubview(discriptionNews)
        
        NSLayoutConstraint.activate([
            discriptionNews.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            discriptionNews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            discriptionNews.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        ])
        
        
    }
    


}
