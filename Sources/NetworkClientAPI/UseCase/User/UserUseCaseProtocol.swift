//
//  UserUseCaseProtocol.swift
//  NetworkClient
//
//  Created by Pedro on 2/7/25.
//

import Foundation

protocol UserUseCaseProtocol {
	func allUsers(descriptionRoutes: DescriptionRoutesUser) async throws -> [UserResponse]
	func newUser(userCreate: Data, descriptionRoutes: DescriptionRoutesUser) async throws -> UserResponse?
	@MainActor func loginUser(userLogin: Data, descriptionRoutes: DescriptionRoutesUser) async throws -> UserTokenResponse?
}
