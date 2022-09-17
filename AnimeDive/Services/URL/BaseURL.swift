//
//  BaseURL.swift
//  AnimeDive
//
//  Created by Robert B on 07/09/2022.
//

import Foundation

extension URL {
    
    static func makeURLWithEndpoint(endpoint: String) -> URL {
        
        URL(string:"https://kitsu.io/api/edge/\(endpoint)")!
        
    }
}



