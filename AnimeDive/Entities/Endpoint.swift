//
//  Endpoint.swift
//  AnimeDive
//
//  Created by Robert B on 08/09/2022.
//

import Foundation

enum Endpoint {
    case allAnime
    case singleAnime (id: Int)
    case moreAnime (offset: Int)
    case episodes
    case singleEpisodes (id: Int)
    
    var value: String {
        switch self {
        case .allAnime:
            return "anime"
        case .singleAnime(id: let id):
            return "anime/\(id)"
        case .moreAnime(offset: let offset):
            return "anime?page[limit]=10&page[offset]=\(offset)"
        case .episodes:
            return "episodes"
        case .singleEpisodes(id: let id):
            return "episodes/\(id)"
        }
    }
    var url: URL {
        .makeURLWithEndpoint(endpoint: value)
    }
}

// comment
//To let U know there are to possible approaches, both correct:
//case .mySample(id: let id, data: let data, ...):
//case let .mySample(id: id, data: data, ...):
//In the (2) you can write let only once just after the case word.
