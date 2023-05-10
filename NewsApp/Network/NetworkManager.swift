//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Adam on 10/05/2023.
//

import Foundation
import Moya

public enum NetworkManager {
    
    case everything
    
}

extension NetworkManager: TargetType {
    public var baseURL: URL {
        return URL(string: "https://newsapi.org/v2/")!
    }
    
    public var path: String {
        switch self {
        case .everything:
            return "everything"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .everything:
            return .get
        }
    }
    
    public var task: Task {
        switch self {
        case .everything:
            return .requestParameters(parameters: ["q": "apple", "apiKey": "bf137dde865147ff97b49b0852f0a971"], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
