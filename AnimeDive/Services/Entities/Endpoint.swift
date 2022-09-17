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
    case episodes
    case singleEpisodes (id: Int)
    // case trending_anime
    
    var value: String{
        switch self{
        case .allAnime: return "anime"
        case .singleAnime(id: let id):
            return "anime/\(id)"
        case .episodes:
            return "episodes"
        case .singleEpisodes(id: let id):
            return "episodes/\(id)"
        }
    }
    var url: URL{
        .makeURLWithEndpoint(endpoint: value)
    }
//    var url: URL {
//        switch self {
//        case .allAnime:
//            return .makeURLWithEndpoint(endpoint: "anime")
//        case .singleAnime(id: let id):
//            return .makeURLWithEndpoint(endpoint: "anime/\(id)")
//        case .episodes:
//            return .makeURLWithEndpoint(endpoint: "episodes")
//        case .singleEpisodes(id: let id):
//            return .makeURLWithEndpoint(endpoint: "episodes/\(id)")
//            //  case .trending_anime:
//            //    return .makeURLWithEndpoint(endpoint: "trending/anime")
//        }
//    }
}
