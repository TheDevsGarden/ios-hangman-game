//
//  Schemas.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import Foundation

struct Film: Codable {
    let Title: String
    let Year: String
    let Ratings: [Rating]
    let Genre: String
    let Director: String
    let Actors: String
}

struct Rating: Codable {
    let Source: String
    let Value: String
}
