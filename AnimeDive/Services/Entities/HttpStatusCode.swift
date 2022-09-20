//
//  http.swift
//  AnimeDive
//
//  Created by Robert B on 07/09/2022.
//

import Foundation

enum HttpStatusCode: Error, CustomStringConvertible {
    
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    //  var localizedDescription: String {
    //      // user description
    //      switch self {
    //      case .badURL, .parsing, .unknown:
    //          return "Sorry, something went wrong."
    //      case .badResponse(statusCode: _):
    //          return " Sorry the connection to your server failed. "
    //      case .url(let error):
    //          return error?.localizedDescription ?? "Something went wrong"
    //      }
    //  }
    
    var description: String {
        // info for debugging
        switch self {
        case .unknown : return "unknown error"
        case .badURL: return "invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
}




