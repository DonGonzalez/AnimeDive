//
//  AttributesData.swift
//  AnimeDive
//
//  Created by Robert B on 07/09/2022.
//

import Foundation

extension Service {
    
    struct AttributesData: Decodable {
        let createdAt: String
        let updatedAt: String
        let slug: String
        let description: String
        let canonicalTitle: String
        let posterImage: PosterImageData
    }
}
