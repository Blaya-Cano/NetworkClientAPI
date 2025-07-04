//
//  DataBaseError.swift
//  Facturacion
//
//  Created by Pedro Jose Blaya Cano on 12/8/24.
//

import SwiftUI

/// Errores enviados por el servidor
///
///  Diferentes errores que puede enviar el servidor cuando accedemos a este
///
/// ```swift
///		getError
///		// Genérico
/// 	badRequest
/// 	// La solicitud no es válida o está mal estructurada.
/// 	unauthorized
/// 	// Se requiere autenticación para acceder al recurso.
/// 	forbidden
/// 	// El usuario no tiene permisos para acceder.
/// 	notFound
/// 	// El recurso solicitado no existe en el servidor.
/// 	methodNotAllowed
/// 	// El método HTTP utilizado no está permitido.
/// 	requestTimeout
/// 	// La solicitud tardó demasiado tiempo y se canceló.
/// 	conflict
/// 	// Conflicto con el estado actual del servidor.
/// 	unprocessableEntity
/// 	// Entidad no procesable
/// 	internalServerError
/// 	// Error inesperado en el servidor.
/// 	notImplemented
/// 	// El servidor no soporta la funcionalidad requerida.
/// 	badGateway
/// 	// Error de comunicación con otro servidor.
/// 	serviceUnavailable
/// 	// El servidor no está disponible temporalmente.
/// 	gatewayTimeout
/// 	// Tiempo de espera agotado en la comunicación con otro servidor.
/// 	errorType(String)
/// 	// Descripción variable del error
/// 	errorDecodingJson
/// 	// Error al decodificar los datos enviados
/// ```
//
enum NetworkErrorResponse: Error {
	case getError
    case badRequest            // La solicitud no es válida o está mal estructurada.
    case unauthorized          // Se requiere autenticación para acceder al recurso.
    case forbidden             // El usuario no tiene permisos para acceder.
    case notFound              // El recurso solicitado no existe en el servidor.
    case methodNotAllowed      // El método HTTP utilizado no está permitido.
    case requestTimeout        // La solicitud tardó demasiado tiempo y se canceló.
    case conflict              // Conflicto con el estado actual del servidor.
    case unprocessableEntity   // Entidad no procesable
    case internalServerError   // Error inesperado en el servidor.
    case notImplemented        // El servidor no soporta la funcionalidad requerida.
    case badGateway            // Error de comunicación con otro servidor.
    case serviceUnavailable    // El servidor no está disponible temporalmente.
    case gatewayTimeout        // Tiempo de espera agotado en la comunicación con otro servidor.
    case errorType(String)
    case errorDecodingJson     // Error al decodificar los datos enviados
}


extension NetworkErrorResponse: CustomStringConvertible {
	
    var description: String {
        switch self {
		case .getError:
			return "Get Error"
        case .badRequest:
            return "400 -  Bad Request"
        case .unauthorized:
            return "401 - Unauthorized"
        case .forbidden:
            return "403 - Forbidden"
        case .notFound:
            return "404 - Not Found"
        case .methodNotAllowed:
            return "405 - Method Not Allowed"
        case .requestTimeout:
            return "408 - Request Timeout"
        case .conflict:
            return "409 - Conflict"
        case .unprocessableEntity:
            return "422 - Unprocessable Entity"
        case .internalServerError:
            return "500 - Internal Server Error"
        case .notImplemented:
            return "501 - Not Implemented"
        case .badGateway:
            return "502 - Bad Gateway"
        case .serviceUnavailable:
            return "503 - Service Unavailable"
        case .gatewayTimeout:
            return "504 - Gateway Timeout"
        case .errorType(let response):
            return response
        case .errorDecodingJson:
            return "El objeto json enviado no ha sido posible decodificar. Verifique campos."
        }
    }
}

extension NetworkErrorResponse {
    
	func codeError(_ error: Int) -> NetworkErrorResponse {
		switch error {
		case 400:
			return NetworkErrorResponse.badRequest
		case 401:
			return NetworkErrorResponse.unauthorized
		case 403:
			return NetworkErrorResponse.forbidden
		case 404:
			return NetworkErrorResponse.notFound
		case 405:
			return NetworkErrorResponse.methodNotAllowed
		case 408:
			return NetworkErrorResponse.requestTimeout
		case 409:
			return NetworkErrorResponse.conflict
		case 422:
			return NetworkErrorResponse.unprocessableEntity
		case 500:
			return NetworkErrorResponse.internalServerError
		case 501:
			return NetworkErrorResponse.notImplemented
		case 502:
			return NetworkErrorResponse.badGateway
		case 503:
			return NetworkErrorResponse.serviceUnavailable
		case 504:
			return NetworkErrorResponse.gatewayTimeout
		default:
			return NetworkErrorResponse.errorType("Desconocdio")
		}
    }
}
