//
//  File.swift
//  NetworkClient
//
//  Created by Pedro Jose Blaya Cano on 20/6/25.
//

import SwiftUI

extension NetworkServiceProtocol {
    
    /// Accedemos al servicio network deseado
    func callService<T: Decodable>(urlRequest: URLRequest, modelType: T.Type) async throws -> T {
        
        let data: Data?
        let response: URLResponse?
        
        do {
            let (dataServer, responseServer) = try await URLSession.shared.data(for: urlRequest)
            data = dataServer
            response = responseServer
        } catch {
            throw NetworkErrorResponse.errorType("Server Disconnected")
        }
        
        var statusCode: Int = 0
        
        if let httpResponse = response as? HTTPURLResponse {
            statusCode = httpResponse.statusCode
            if statusCode != 200 {
                guard let dataErrorResponse = try? JSONDecoder().decode(NetworkErrorServer.self, from: data!) else {
					throw NetworkErrorResponse.getError.codeError(statusCode)
                }
                throw NetworkErrorResponse.errorType(dataErrorResponse.detail)
            }
            guard let dataResponse = try? JSONDecoder().decode(T.self, from: data!) else {
                throw NetworkErrorResponse.errorDecodingJson
            }
            return dataResponse
        }
        throw NetworkErrorResponse.conflict
    }
}
