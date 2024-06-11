//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Слава Васильев on 05.06.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var rssItems: [RSSItem]?
    private var storeUrlForBrowser: String?
    private lazy var scrollView = UIScrollView()
    
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
    
    lazy var browserButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(browserButtonTap), for: .touchUpInside)
        button.setTitle("Перейти в браузер", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        return button
    }()
    
    init(with source: RSSItem){
        super.init(nibName: nil, bundle: nil)
        titleNews.text = source.title
        imageNews.image = source.image
        discriptionNews.text = source.description
        dateNews.text = source.pubData
        storeUrlForBrowser = source.link
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lificycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self , action: #selector(shareButton))
    }
    
    //MARK: - ShareButtonSetup
    @objc func shareButton(){
        
        if let urladdress = storeUrlForBrowser {
            let items: [String] = [urladdress]
            let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(avc, animated: true)
        }
    }
    
    @objc func browserButtonTap(){
        
        guard let urladdress = storeUrlForBrowser else { return }
        print(urladdress)
        
        if let url = URL(string: urladdress ) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
}

//MARK: - SetupUI
extension DetailViewController {
    func setupUI(){
        view.backgroundColor = .systemBackground
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        [titleNews, imageNews, dateNews, discriptionNews, browserButton].forEach {
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
            //            discriptionNews.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            discriptionNews.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            browserButton.topAnchor.constraint(equalTo: discriptionNews.bottomAnchor, constant: 20),
            browserButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            browserButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            browserButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            browserButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            browserButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
    }
}
