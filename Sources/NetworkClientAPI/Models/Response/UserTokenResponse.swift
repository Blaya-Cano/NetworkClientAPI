//
//  UserTokenResponse.swift
//  NetworkClient
//
//  Created by Pedro Jose Blaya Cano on 17/6/25.
//


struct UserTokenResponse: Decodable {
	let token: String
	let type: String
	
	private enum CodingKeys: String, CodingKey {
		case token = "access_token"
		case type = "token_type"
	}
}
