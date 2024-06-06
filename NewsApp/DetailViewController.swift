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
    
    
    init(with source: CellSource){
        super.init(nibName: nil, bundle: nil)
        titleNews.text = source.title
        imageNews.image = source.image
        discriptionNews.text = source.discription
        dateNews.text = source.time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        [titleNews, imageNews, dateNews, discriptionNews].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleNews.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleNews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            titleNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            imageNews.topAnchor.constraint(equalTo: titleNews.bottomAnchor, constant: 10),
            imageNews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            imageNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            imageNews.heightAnchor.constraint(equalToConstant: 200),

            dateNews.topAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: 15),
            dateNews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            dateNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            discriptionNews.topAnchor.constraint(equalTo: dateNews.bottomAnchor, constant: 10),
            discriptionNews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            discriptionNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            
        ])
        
        
    }
    


}
