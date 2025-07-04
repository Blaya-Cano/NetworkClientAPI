//
//  Routes.swift
//  NetworkClient
//
//  Created by Pedro on 27/4/25.
//

import Foundation

///
///  Se describen todas las rutas activas en el servidor para poder ser utlizadas
///
/// ```swift
/// https://www.ejemplo.com/productos?id=123
/// httpProtocol 		= https://
/// domainAndExtension 	= www.ejemplo.com, 127.0.0.1:8000
/// route 				= /productos
/// queryParameters		= ?id=123
/// ```
///
/// ```swift
/// router				http://127.0.0.1:8000/
/// users				http://127.0.0.1:8000/api/v1/users/
/// register			http://127.0.0.1:8000/api/v1/user/register
/// login				http://127.0.0.1:8000/api/v1/user/login
/// ```
enum DescriptionRoutesUser {
	case router				/// http://127.0.0.1:8000/
	case users				/// http://127.0.0.1:8000/api/v1/users/
	case user(Int)			/// http://127.0.0.1:8000/api/v1/users/1
	case register			/// http://127.0.0.1:8000/api/v1/user/register
	case login				/// http://127.0.0.1:8000/api/v1/user/login
	case logged				/// http://127.0.0.1:8000/api/v1/user/logged
	case update				/// http://127.0.0.1:8000/api/v1/user/update
}

extension DescriptionRoutesUser {
	
	var valuehttpMethod: String {
		switch self {
		case .router, .users, .logged, .user(_):
			return "GET"
		case .register, .login:
			return "POST"
		case .update:
			return "PUT"
		}
	}
}

extension DescriptionRoutesUser {
	
	var valueDomainAndExtension: String {
		switch self {
		default:
			return "127.0.0.1"
		}
	}
}

extension DescriptionRoutesUser {
	
	var port: Int {
		switch self {
		default:
			return 8000
		}
	}
}

extension DescriptionRoutesUser {
	
	var api: String {
		switch self {
		default:
			return "api/v1/"
		}
	}
}

extension DescriptionRoutesUser {
	
	var valueRoute: String {
		switch self {
		case .router:
			return ""
		case .users:
			return "users/"
		case .user(let id):
			return "user/\(id)/"
		case .register:
			return "user/register"
		case .login:
			return "user/login"
		case .logged:
			return "user/logged"
		case .update:
			return "user/update"
		}
	}
}
