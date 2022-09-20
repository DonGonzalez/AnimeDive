//
//  Data.swift
//  AnimeDive
//
//  Created by Robert B on 07/09/2022.
//

import Foundation

extension Service {
    
    struct Anime: Decodable {
        var data: [AnimeData]
    }
    
}
