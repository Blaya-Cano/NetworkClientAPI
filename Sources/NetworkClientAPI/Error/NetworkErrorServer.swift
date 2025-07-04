//
//  ErrorResponse.swift
//  NetworkClient
//
//  Created by Pedro Jose Blaya Cano on 17/6/25.
//


struct NetworkErrorServer: Decodable {
	let detail: String
    
    private enum CodingKeys: String, CodingKey {
        case detail
    }
}

struct ResponseData: Codable {
    let detail: [ErrorDetail]
}

struct ErrorDetail: Codable {
    let type: String
    let msg: String
}
