//
//  NetworkManagement.swift
//  NetworkClient
//
//  Created by Pedro on 21/4/25.
//

import SwiftUI

/// Potocolos para crear un NetworkManagmeent
///
///	```swift
///	func getAllUsers() async
/// func setNewUser(_ userCreate: UserProtocol) async -> UserResponse?
/// func getLogin(_ userLogin: UserProtocol) async -> String?
///	```
protocol NetworkManagementProtocol {
	func getAllUsers() async
	func setNewUser(userCreate: [String: String]) async -> Bool
	func getLogin(userLogin: [String: String]) async -> String?
}

/// Clase para manejar nuestro acceso a los usuarios
@Observable @MainActor
public class NetworkManagementUser: NetworkManagementProtocol {
	
	private let userUseCase: UserUseCase = UserUseCase()
	
	// MARK: - ATRIBUTOS
	
	/// Usuarios obtenidos
	var users: [UserResponse] = []
	
	/// Errores en el acceso a los datos
	public var networkError: String? = nil
	
	public init() {}
	
	// MARK: - METODOS O FUNCIONES
	
	/// Obtenemos todos los usuarios
	public func getAllUsers() async {
		await allUsers()
	}
	
	/// Codificados todos los usuarios a Data
	public func getUsers() async -> Data? {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		do {
			return try encoder.encode(users)
		} catch {
			print("Error al codificar JSON: \(error)")
		}
		return nil
	}
	
	/// Agregar un nuevo usuario
	///
	///  Función para agregar un nuevo usuario en el servidor
	///
	/// > Important: Debe de comprobarse que los datos no estan en blanco
	///
	///	- Throws: nil
	///
	/// - Parameter userCreate: Recibe un diccionario  [String: String], compueste de  email y passwsord
	/// - Returns: Devuelve TRUE o FALSE
	//
	public func setNewUser(userCreate: [String: String]) async -> Bool {
		guard let userCreateClean = cleanUserCredentials(userCreate) else { return false }
		return await newUser(userCreate: User(email: userCreateClean["email"]!, password: userCreateClean["password"]!))
	}
	
	/// Agregar un nuevo usuario
	///
	///  Función para loguear un usuario en el servidor
	///  
	/// > Important: Debe de comprobarse que los datos no estan en blanco
	///
	///	- Throws: nil
	///
	/// - Parameter userLogin:  Recibe un diccionario  [String: String], compueste de  email y passwsord
	/// - Returns: Devuelve lun TOKEN
	//
	public func getLogin(userLogin: [String: String]) async -> String? {
		guard let userLoginClean = cleanUserCredentials(userLogin) else { return nil }
		return await loginUser(userLogin: UserLogin(email: userLoginClean["email"]!, password: userLoginClean["password"]!))
	}
}

extension NetworkManagementUser {
	
	/// Comprobamos los datos enviados para evitar posibles intentos de acceso ilegal en el servidor
	private func cleanUserCredentials(_ userCreate: [String: String]) -> [String: String]? {
		networkError = nil
		if userCreate.isEmpty {
			networkError = NetworkErrorRequest.noData.description
			return nil
		}
		guard let _ = userCreate["email"] else {
			networkError = NetworkErrorRequest.userRequired.description
			return nil
		}
		guard let _ = userCreate["password"] else {
			networkError = NetworkErrorRequest.passwordRequired.description
			return nil
		}
		return userCreate
	}
}

extension NetworkManagementUser {

	/// Get all users
	private func allUsers() async {
		do {
			self.users = try await userUseCase.allUsers(descriptionRoutes: .users)
			networkError = nil
		} catch let error as NetworkErrorResponse {
			networkError = error.description
		} catch {
			networkError = "Unknown error \(error)"
		}
	}
	
	/// New User
	private func newUser(userCreate: UserProtocol) async -> Bool {
		do {
			let user = try await userUseCase.newUser(userCreate: createdJson(userCreate), descriptionRoutes: .register)
			self.networkError = nil
			await allUsers()
			return user?.isActive ?? false
		} catch let error as NetworkErrorResponse {
			self.networkError = error.description
		} catch {
			self.networkError = "Unknown error \(error)"
		}
		return false
	}
	
	/// Login User
	@MainActor
	private func loginUser(userLogin: UserProtocol) async -> String? {
		do {
			let user = try await userUseCase.loginUser(userLogin: createdParameters(userLogin), descriptionRoutes: .login)
			self.networkError = nil
			await allUsers()
			return user?.token
		} catch let error as NetworkErrorResponse {
			self.networkError = error.description
		} catch {
			self.networkError = "Unknown error \(error)"
		}
		return "ERROR TOKEN"
	}
}

extension NetworkManagementUser {
	
	/// Convertimos un struct en un json
	///
	///  Esta función es utilizada cuando creamos un nuevo usuario. Para lo que recibirá un ``User`` y devolverá un ``Data`` generado con el json obtenido.
	///
	/// > Important: Verificar datos enviados
	///
	/// ```swift
	/// let json: [String:Any] = [
	///		"email": user.email,
	///		"password": user.password
	///	]
	///	return try! JSONSerialization.data(withJSONObject: json)
	/// ```
	/// - Parameter user: Recibe un struct conformado a ``UserProtocol``
	/// - Returns: Retorna un jason en formato ``Data``
	private func createdJson(_ user: UserProtocol) -> Data {
		let json: [String:Any] = [
			"email": user.email,
			"password": user.password
		]
		return try! JSONSerialization.data(withJSONObject: json)
	}
	
	/// Convertimos un struct en un json
	///
	///  Esta función es utilizada cuando nos logueamos. Para lo que recibirá un ``UserLogin`` y devolverá un ``Data``
	///
	/// > Important: Verificar datos enviados
	///
	/// - Parameter user: Recibe un struct conformado a ``UserProtocol``
	/// - Returns: Retorna un jason en formato ``Data``
	private func createdParameters(_ user: UserProtocol) -> Data {
		let parameters = user.getParameters()
		return parameters.data(using: .utf8)!
	}
}


