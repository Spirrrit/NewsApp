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
    let date: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14)
        lable.textColor = .gray
        return lable
    }()
    let source: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 14)
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
        [title, discription, image , date, source].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            discription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            discription.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            discription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            image.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -15),
            image.heightAnchor.constraint(equalToConstant: 100),
            image.widthAnchor.constraint(equalToConstant: 100),

            
            date.topAnchor.constraint(equalTo: discription.bottomAnchor, constant: 10),
            date.topAnchor.constraint(equalTo: discription.bottomAnchor, constant: 10),
            date.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
    
            source.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            source.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            source.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            

        ])
    }
    func configure(cellSource: RSSItem){
        title.text = cellSource.title
        discription.text = cellSource.description
        date.text = cellSource.pubData.toRusString
        image.image = cellSource.image
        source.text = cellSource.resource
        
    }
    // CoreData
    func configureCoreDataCell(cellSource: RSSItems){
        title.text = cellSource.rssTitle
        discription.text = cellSource.rssDescription
        date.text = cellSource.rssPubData.toRusString 
        source.text = cellSource.rssResource
        image.image = SupportFunc.getImage(str: cellSource.rssImage ?? "")
        
    }
    
    
}
