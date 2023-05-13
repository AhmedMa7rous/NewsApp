//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Adam on 10/05/2023.
//

import Foundation

class DetailsViewModel {
    private(set) var article: ArticlesEntity
    
    init(with article: ArticlesEntity) {
        self.article = article
    }
}
