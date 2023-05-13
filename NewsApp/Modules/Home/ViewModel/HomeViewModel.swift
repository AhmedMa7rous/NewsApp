//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Adam on 10/05/2023.
//

import Foundation
import CoreData
import Moya
import RxSwift
import RxRelay

class HomeViewModel {
    
    //MARK: Properties
    private let provider = MoyaProvider<NetworkManager>()
    private(set) var news = BehaviorSubject(value: [ArticlesEntity]())
    private(set) var items = [Article]()
    var disposeBag: DisposeBag = DisposeBag()
    var onSuccess: PublishSubject<Void> = PublishSubject<Void>()
    var onError: PublishSubject<String> = PublishSubject<String>()
    var showLoader: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)

    
 /*===================================================================*/
    //MARK: - Intents
    func checkConnection() {
        if NetworkMonitor.shared.isConnected {
            deleteAll()
            fetchData()
        } else {
            news.on(.next(CoreDataManager.shared.fetchArticles()))
            onSuccess.onNext(())
        }
    }
    private func fetchData() {
        provider.request(.everything) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    self.items = try response.map(News.self).articles
                    self.saveToCoredata(With: self.items)
                    //self.news.on(.next(try response.map(News.self).articles))
                    self.onSuccess.onNext(())
                } catch {
                    print(error)
                    self.onError.onNext(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.onError.onNext(error.localizedDescription)
            }
        }
    }

/*========================================================*/
    //MARK: - Core Data Functions
    ///This Function responsible for saving to core data
    func saveToCoredata(With items: [Article]) {
        for item in items {
            //Create a ArticleEntity Object
            let newArticle = ArticlesEntity(context: CoreDataManager.shared.viewContext)
            newArticle.title = item.title
            newArticle.author = item.author
            newArticle.descrip = item.description
            newArticle.url = item.url
            newArticle.urlToImage = item.urlToImage
            newArticle.publishedAt = item.publishedAt
            newArticle.content = item.content
            
            //Save the data
            CoreDataManager.shared.saveContext()
        }
        //Re-fetch the data
        self.news.on(.next(CoreDataManager.shared.fetchArticles()))
    }
    
    ///This Function responsible for deleting  core data
    func deleteAll() {
        for item in CoreDataManager.shared.fetchArticles() {
            CoreDataManager.shared.viewContext.delete(item)
        }
    }
}
