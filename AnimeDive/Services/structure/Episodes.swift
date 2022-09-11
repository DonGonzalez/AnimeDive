//
//  File.swift
//  AnimeDive
//
//  Created by Robert B on 10/09/2022.
//

import Foundation
extension Service {
    
    struct Episodes: Decodable {
        var data: [EpisodesData]
    }
}
