//
//  UseCaseUser.swift
//  NetworkClient
//
//  Created by Pedro Jose Blaya Cano on 21/5/25.
//

import Foundation

final class UserUseCase: NetworkRequestProtocol, UserUseCaseProtocol, Sendable {
	
	/// Protocolo de acceso a internet ``HttpProtocol``
	var httpProtocol: HttpProtocol  {
		return currentEnvironment.httpProtocol
	}
	
	/// All Users
	func allUsers(descriptionRoutes: DescriptionRoutesUser) async throws -> [UserResponse] {
		let components = getComponents(descriptionRoutes: descriptionRoutes)
		return try await requestCreation(httpMethod: descriptionRoutes.valuehttpMethod, components: components, modelType: [UserResponse].self)
	}
	
	/// New User
	///
	///  Se recibe el usuario y su password en formato ``Data`` y tel tipo de ruta a utlizar ``DescriptionRoutes``.
	func newUser(userCreate: Data, descriptionRoutes: DescriptionRoutesUser) async throws -> UserResponse? {
		let components = getComponents(descriptionRoutes: descriptionRoutes)
		return try await requestCreation(httpMethod: descriptionRoutes.valuehttpMethod,
										 contentType: "application/json",
										 components: components,
										 bodyData: userCreate,
										 modelType: UserResponse.self)
	}
	
	/// Login User
	///
	///  Se recibe el usuario y su password en formato ``Data`` y tel tipo de ruta a utlizar ``DescriptionRoutes``.
	@MainActor
	func loginUser(userLogin: Data, descriptionRoutes: DescriptionRoutesUser) async throws -> UserTokenResponse? {
		let components = getComponents(descriptionRoutes: descriptionRoutes)
		return try await requestCreation(httpMethod: descriptionRoutes.valuehttpMethod,
										 contentType: "application/x-www-form-urlencoded",
										 components: components,
										 bodyData: userLogin,
										 modelType: UserTokenResponse.self)
	}
}

extension UserUseCase {
	
	private func getComponents(descriptionRoutes: DescriptionRoutesUser) -> URLComponents {
		var components = URLComponents()
		components.scheme = httpProtocol.rawValue     						// http/https
		components.host = descriptionRoutes.valueDomainAndExtension			// food2fork.ca
		components.port = descriptionRoutes.port							// 8000
		components.path = "/" + descriptionRoutes.api						// api/v1/
		components.path = components.path + descriptionRoutes.valueRoute	// recipe/search/
		return components
	}
}
