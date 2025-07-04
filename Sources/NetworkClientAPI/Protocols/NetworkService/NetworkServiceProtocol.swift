//
//  NetworkService.swift
//  Example NetworkService
//
//  Created by Pedro Jose Blaya Cano on 26/1/24.
//

import Foundation
import SwiftUI

protocol NetworkServiceProtocol {
	func generateRequest(httpMethod: String, components: URLComponents) throws -> URLRequest
	func generateRequest(httpMethod: String, contentType: String, components: URLComponents, bodyData: Data) throws -> URLRequest
	func callService<T: Decodable>(urlRequest: URLRequest, modelType: T.Type) async throws -> T
}

