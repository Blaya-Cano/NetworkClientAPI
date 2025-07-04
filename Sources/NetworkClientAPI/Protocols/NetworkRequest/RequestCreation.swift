//
//  File.swift
//  NetworkClient
//
//  Created by Pedro Jose Blaya Cano on 20/6/25.
//

import SwiftUI

extension NetworkRequestProtocol {
	
	func requestCreation<T: Decodable>(
			httpMethod: String,
			components: URLComponents,
			modelType: T.Type) async throws -> T {
			
		let request = try generateRequest(httpMethod: httpMethod, components: components)
		return try await callService(urlRequest: request, modelType: modelType)
	}
	
	func requestCreation<T: Decodable>(
			httpMethod: String,
			contentType: String,
			components: URLComponents,
			bodyData: Data,
			modelType: T.Type) async throws -> T {
			
		let request = try generateRequest(httpMethod: httpMethod, contentType: contentType, components: components, bodyData: bodyData)
		return try await callService(urlRequest: request, modelType: modelType)
	}
}
