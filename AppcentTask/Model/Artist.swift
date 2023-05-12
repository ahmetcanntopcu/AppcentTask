//
//  Artist.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 11.05.2023.
//

import Foundation

struct ArtistResponse: Codable {
    let data: [Artist]
}

struct Artist: Codable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall: String
    let pictureMedium: String
    let pictureBig: String
    let pictureXL: String

    
    enum CodingKeys: String, CodingKey {
        case id, name,picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXL = "picture_xl"
      
    }
}
