//
//  AttributesData.swift
//  AnimeDive
//
//  Created by Robert B on 07/09/2022.
//
import Foundation

struct AttributesData: Decodable {
    
    let createdAt: String
    let updatedAt: String
    let description: String
    let canonicalTitle: String
    let episodeCount: Int
    let posterImage: PosterImageData
}
