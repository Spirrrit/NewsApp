//
//  Resource.swift
//  NewsApp
//
//  Created by Слава Васильев on 05.06.2024.
//

import Foundation
import UIKit

struct CellSource {
    let title: String
    let discription: String
    let image: UIImage?
    let time: String
    let source: String
}

struct Resource {
    static func makeSource() -> [CellSource] {
        [
            .init(title: "Apple разрабатывает более тонкую версию iPhone, пишут СМИ", 
                  discription: """
                Компания Apple разрабатывает более тонкую версию iPhone, которая может быть выпущена в 2025 году, сообщает издание  ссылаясь на источники.
                Тонкий iPhone может быть выпущен одновременно с iPhone 17, ожидаемым в сентябре 2025 года, - сообщает издание.По данным источников, цена на устройство может быть выше, чем на iPhone Pro Max, который в настоящее время является самой дорогой моделью Apple и стоит 1200 долларов.
            """, 
                  image: UIImage(named: "apple"),
                  time: "01.01.2024",
                  source: "Source"),
            
            .init(title: "Предложения Microsoft, новое поколение iPad и защита данных", 
                  discription: """
                    – Зачем Microsoft предложил сотрудникам из Китая релоцироваться в другие страны?
                    – Потеряет ли Microsoft рынок в России?
                    – Как защитить свои данные от мошенников?
                    – Сколько придется заплатить за седьмое поколение iPad Pro от Apple?

                    Новости технологий и бизнеса обсуждаем в программе "Черная пятница" в эфире радио Sputnik.

                    """, 
                  image: UIImage(named: "microsoft"),
                  time: "01.01.2024",
                  source: "Source"),
            
            .init(title: "Apple удалила из App Store в Китае WhatsApp и Threads",
                  discription: """
                    
                    Американская Apple удалила из свое магазина приложений App Store в Китае мессенджер WhatsApp и соцсеть Threads, которые принадлежат Meta Platforms (деятельность компании запрещена в России как экстремистская), по требованию властей Китая, пишет газета Wall Street Journal.
                    «
                    "WhatsApp и Threads от Meta Platforms, а также платформы обмена сообщениями Signal, Telegram и Line были удалены из китайского App Store в пятницу. Apple заявила, что ей было приказано властями удалить определенные приложения из соображений национальной безопасности", - пишет газета.
                    "Мы обязаны соблюдать законы стран, в которых мы работаем, даже если мы не согласны с ними", - приводит газета комментарий представителя Apple.
                    

                    """,
                  image: UIImage(named: "whatsApp"),
                  time: "01.01.2024",
                  source: "Source"),
        ]
    }
}
