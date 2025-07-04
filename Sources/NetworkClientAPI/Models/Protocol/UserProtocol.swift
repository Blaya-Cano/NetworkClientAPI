//
//  UserProtocol.swift
//  NetworkClient
//
//  Created by Pedro on 1/7/25.
//


protocol UserProtocol: Sendable {
	var email: String { get }
	var password: String { get }
	func getParameters() -> String
}
