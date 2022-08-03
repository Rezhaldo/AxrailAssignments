//
//  GamesModel.swift
//  MyGameKatalog
//
//  Created by Kevin Chilmi Rezhaldo on 07/07/22.
//

import Foundation

struct GamesResponse: Codable {
    let count: Int
    let next: String
    var results: [ Games?]
}

struct Games: Codable {
    let id: Int?
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    
    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
    }
}
