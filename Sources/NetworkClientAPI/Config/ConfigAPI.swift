//
//  Config.swift
//  NetworkClient
//
//  Created by Pedro Jose Blaya Cano on 8/5/25.
//

import Foundation

enum Environment {
    case production
    case development
	
    var httpProtocol: HttpProtocol {
        switch self {
        case .production:
            return .https
        case .development:
            return .http
        }
    }
}

let currentEnvironment: Environment = .development
