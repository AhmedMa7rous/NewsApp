//
//  HomeViewModel.swift
//  NewsApp
//
//  Created by Adam on 10/05/2023.
//

import Foundation
import Moya
import RxSwift
import RxRelay

class HomeViewModel {
    //MARK: Properties
    private let provider = MoyaProvider<NetworkManager>()
    private(set) var news = BehaviorSubject(value: [Article]())
    private(set) var items = [Article]()
    var disposeBag: DisposeBag = DisposeBag()
    var onSuccess: PublishSubject<Void> = PublishSubject<Void>()
    var onError: PublishSubject<String> = PublishSubject<String>()
    var showLoader: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    
    //MARK: - Intents
    func fetchData() {
        provider.request(.everything) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    self.news.on(.next(try response.map(News.self).articles))
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
}
