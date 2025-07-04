//
//  NetworkErrorRequest.swift
//  NetworkClient
//
//  Created by Pedro on 3/7/25.
//

import SwiftUI

/// Errores enviados al general el REQUEST
///
/// Diferentes errores que pueden ocurrir al confeccionar la URL
///
/// ```swift
/// 	.invalidUrl
/// 	URL invalida
/// ```
enum NetworkErrorRequest: Error {
	case invalidUrl	           	// URL inválida
	case passwordRequired		// Password requerida
	case userRequired			// Usuario requerido
	case noData					// No enviamos datos
}

extension NetworkErrorRequest: CustomStringConvertible {
	var description: String {
		switch self {
		case .invalidUrl:
			return "La URL es inválida"
		case .passwordRequired:
			return "Se requiere un password"
		case .userRequired:
			return "Se requiere un usuario"
		case .noData:
			return "No se envían datos"
		}
	}
}
