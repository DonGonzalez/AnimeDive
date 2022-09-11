//
//  url.swift
//  AnimeDive
//
//  Created by Robert B on 08/09/2022.
//

import Foundation
extension endpoint{
    
    var url: URL {
        
        switch self {
        case .allAnime:
            return .makeURLWithEndpoint(endpoint: "anime")
        case .singleAnime(id: let id):
            return .makeURLWithEndpoint(endpoint: "anime/\(id)")
        case .episodes:
            return .makeURLWithEndpoint(endpoint: "episodes")
        case .singleEpisodes(id: let id):
            return .makeURLWithEndpoint(endpoint: "episodes/\(id)")
      //  case .trending_anime:
        //    return .makeURLWithEndpoint(endpoint: "trending/anime")
        }
    }
    
    
}
