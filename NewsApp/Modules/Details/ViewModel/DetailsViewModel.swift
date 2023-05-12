//
//  DetailsViewModel.swift
//  NewsApp
//
//  Created by Adam on 10/05/2023.
//

import Foundation

class DetailsViewModel {
    private(set) var article: Article
    
    init(with article: Article) {
        self.article = article
    }
}
