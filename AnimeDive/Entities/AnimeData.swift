//
//  AnimeData.swift
//  AnimeDive
//
//  Created by Robert B on 07/09/2022.
//
import Foundation

struct AnimeData: Decodable {
    let id: String
    let type: String
    let attributes: AttributesData
}

