//
//  Album.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 12.05.2023.
//

import Foundation

struct AlbumResponse: Codable {
    let data: [Album]
}

struct Album: Codable {
    let id: Int
    let name: String
    let link: String
    let share: String
    let picture: String
    let pictureMedium: String
    let pictureBig: String
    let pictureXL: String
    let nbAlbum: Int
    let nbFan: Int
    let tracklist: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, share, picture
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXL = "picture_xl"
        case nbAlbum = "nb_album"
        case nbFan = "nb_fan"
        case tracklist, type
    }
}
struct Album2: Codable {
    let id: Int
    let title: String
    let cover: String
    let coverSmall: String
    let coverMedium: String
    let coverBig: String
    let coverXL: String
    let md5Image: String
    let tracklist: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXL = "cover_xl"
        case md5Image = "md5_image"
        case tracklist
        case type
    }
}

