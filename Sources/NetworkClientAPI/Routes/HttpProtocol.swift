//
//  HttpProtocol.swift
//  NetworkClient
//
//  Created by Pedro Jose Blaya Cano on 20/6/25.
//

import SwiftUI

/// Indicamos como se debe de acceder al recurso
///
/// ```swift
/// 	.http = "http"
///		.https = "https"
/// ```
enum HttpProtocol: String {
    case http = "http"
    case https = "https"
}
