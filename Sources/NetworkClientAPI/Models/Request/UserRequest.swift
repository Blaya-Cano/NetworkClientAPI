//
//  UserProtocol.swift
//  NetworkClient
//
//  Created by Pedro on 1/7/25.
//

import Foundation

/// Creacion de un nuevo usuario
struct User: UserProtocol {
	
	let email: String
	let password: String
	
	/// Inicializamos el nuevo usuario
	/// - Parameters:
	///   - email: Email identifiactivo del usuario ``<String>``
	///   - password: Password de acceso del usuario ``<String>``
	//
	init(email: String, password: String) {
		self.email = email
		self.password = password
	}
	
	/// Obtenemos el email y el password del usuario
	/// - Returns: Datos principales del usuario ``<String>``
	//
	func getParameters() -> String {
		return "username=\(self.email)&password=\(self.password)"
	}
}

/// Logeo de usuario
struct UserLogin: UserProtocol {
	
	let email: String
	let password: String
	
	/// Inicializamos el nuevo usuario
	/// - Parameters:
	///   - email: Email identifiactivo del usuario ``<String>``
	///   - password: Password de acceso del usuario ``<String>``
	//
	init(email: String, password: String) {
		self.email = email
		self.password = password
	}
	
	/// Obtenemos el email y el password del usuario
	/// - Returns: Datos principales del usuario ``<String>``
	//
	func getParameters() -> String {
		return "username=\(self.email)&password=\(self.password)"
	}
}
