//
//  http.swift
//  AnimeDive
//
//  Created by Robert B on 07/09/2022.
//

import Foundation


enum httpStatusCode: Error, CustomStringConvertible {
   
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown

   
    }
  
    


