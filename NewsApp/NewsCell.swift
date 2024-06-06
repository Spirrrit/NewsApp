//
//  NewsCell.swift
//  NewsApp
//
//  Created by Слава Васильев on 05.06.2024.
//

import UIKit

class NewsCell: UITableViewCell {

    var title: UILabel = {
        let lable = UILabel()
        lable.font = .boldSystemFont(ofSize: 16)
        lable.numberOfLines = 3
        return lable
    }()
    let discription: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14)
        lable.numberOfLines = 2
        return lable
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    let time: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 10)
        lable.textColor = .lightGray
        return lable
    }()
    let source: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 10)
        lable.textColor = .lightGray
        return lable
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(){
        [title, discription, image , time, source].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    
        
        NSLayoutConstraint.activate([
        
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.widthAnchor.constraint(equalToConstant: 130),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            discription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            discription.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            discription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            time.topAnchor.constraint(equalTo: discription.bottomAnchor, constant: 10),
            time.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            time.trailingAnchor.constraint(equalTo: source.leadingAnchor, constant: -10),
            
            source.topAnchor.constraint(equalTo: discription.bottomAnchor, constant: 10),
            source.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            source.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        
        ])
    }
    func configure(cellSource: RSSItem){
//        title.text = cellSource.title
//        discription.text = cellSource.discription
//        image.image = cellSource.image
//        time.text = cellSource.time
//        source.text = cellSource.source
        title.text = cellSource.title
        discription.text = cellSource.description
        time.text = cellSource.pubData
        image.image = cellSource.image
    }
    
}
