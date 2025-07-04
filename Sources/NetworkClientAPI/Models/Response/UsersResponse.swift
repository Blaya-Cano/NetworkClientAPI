//
//  UsersResponse.swift
//  NetworkClient
//
//  Created by Pedro on 21/4/25.
//

import Foundation

struct UserResponse: Decodable, Identifiable, Encodable {
    let id: Int
    let email: String
    let isActive: Bool
    let role: String
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case email, role
        case isActive = "is_active"
        case createdAt = "created_at"
    }
}
