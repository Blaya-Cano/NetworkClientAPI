//
//  File.swift
//  NetworkClient
//
//  Created by Pedro Jose Blaya Cano on 20/6/25.
//

import SwiftUI

extension NetworkServiceProtocol {
	
	public func generateRequest(httpMethod: String, components: URLComponents) throws -> URLRequest {
		
		if let url = components.url {
			print("URL construida: \(url)")
			var request = URLRequest(url: url)
			request.httpMethod = httpMethod
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			return request
		} else {
			throw NetworkErrorRequest.invalidUrl
		}
	}
	
	public func generateRequest(httpMethod: String, contentType: String, components: URLComponents, bodyData: Data) throws -> URLRequest {
		
		if let url = components.url {
			var request = URLRequest(url: url)
			request.httpMethod = httpMethod
			request.setValue(contentType, forHTTPHeaderField: "Content-Type")
			request.httpBody = bodyData
			return request
		} else {
			throw NetworkErrorRequest.invalidUrl
		}
	}
}
