//
//  Endpoint.swift
//  AnimeDive
//
//  Created by Robert B on 08/09/2022.
//

import Foundation

enum Endpoint {
    
    case singleAnime (id: Int)
    case moreAnime (offset: Int, sort: String, filter: String, search: String)
    case episodes
    case singleEpisodes (id: Int)
    case searchAnime (searchText: String, sort: String, filter: String)
    
    var value: String {
        switch self {
            
        case .singleAnime(id: let id):
            return "/anime/\(id)"
        case let .moreAnime(offset: offset, sort: sort, filter: filter, search: search):
            return "/anime?page[limit]=10&page[offset]=\(offset)\(search)\(sort)\(filter)"
        case .episodes:
            return "/episodes"
        case .singleEpisodes(id: let id):
            return "/episodes/\(id)"
        case let .searchAnime (searchText: text, sort: sort, filter: filter):
            // cut space when user put text with space
            return "\(text)\(sort)\(filter)"
        }
    }
    
    var url: URL {
        .makeURLWithEndpoint(endpoint: value)
    }
}

extension Endpoint {
    
    
    
}
// comment
//To let U know there are to possible approaches, both correct:
//case .mySample(id: let id, data: let data, ...):
//case let .mySample(id: id, data: data, ...):
//In the (2) you can write let only once just after the case word.
