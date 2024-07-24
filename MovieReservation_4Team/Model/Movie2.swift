//
//  Movie.swift
//  MovieReservation_4Team
//
//  Created by ahnzihyeon on 7/24/24.
//

import Foundation

struct Movie2: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}
