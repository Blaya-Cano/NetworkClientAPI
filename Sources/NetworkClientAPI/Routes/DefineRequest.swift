//
//  DefineRequest.swift
//  NetworkClient
//
//  Created by Pedro on 27/4/25.
//

import Foundation

/// Descripción genérica de la URL
struct DefineRequest {
    let httpProtocol: HttpProtocol
    let httpMethod: String
    let domainAndExtension: String
    let port: Int
    let api: String
    let route: String
    let queryParameters: [String:String]?
    let headers: [String:String]?
    let body: [String:String]?
    let bodyData: Data?
    
    init(httpProtocol: HttpProtocol, descriptionRoutes: DescriptionRoutesUser, queryParameters: [String : String]?, headers: [String : String]?, body: [String : String]?, bodyData: Data?) {
        self.httpProtocol = httpProtocol
        self.httpMethod = descriptionRoutes.valuehttpMethod
        self.domainAndExtension = descriptionRoutes.valueDomainAndExtension
        self.port = descriptionRoutes.port
        self.api = descriptionRoutes.api
        self.route = descriptionRoutes.valueRoute
        self.queryParameters = queryParameters
        self.headers = headers
        self.body = body
        self.bodyData = bodyData
    }
}
