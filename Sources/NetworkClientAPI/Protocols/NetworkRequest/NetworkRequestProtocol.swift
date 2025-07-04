//
//  ProfileNetwork.swift
//  Example NetworkService
//
//  Created by Pedro Jose Blaya Cano on 26/1/24.
//

import SwiftUI

/// Tenemos que ajustar nuestra clase a este protocolo para acceder a un servidor
protocol NetworkRequestProtocol: NetworkServiceProtocol {
	func requestCreation<T: Decodable>(httpMethod: String, components: URLComponents, modelType: T.Type) async throws -> T
	func requestCreation<T: Decodable>(httpMethod: String, contentType: String, components: URLComponents, bodyData: Data, modelType: T.Type) async throws -> T
}
