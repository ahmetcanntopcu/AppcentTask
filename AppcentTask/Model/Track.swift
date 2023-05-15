//
//  Track.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 14.05.2023.
//

import Foundation

struct TrackResponse: Codable {
    let data: [Track]
}

struct Track: Codable {
    let id: Int
    let title: String
    let link: String
    let duration: Int
    let rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics: Int
    let explicitContentCover: Int
    let preview: String
    let md5Image: String
    let album: AlbumDetail

    enum CodingKeys: String, CodingKey {
        case id, title, link, duration, rank, preview, album
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case md5Image = "md5_image"
    }
}



struct AlbumDetail: Codable {
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
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXL = "cover_xl"
        case md5Image = "md5_image"
        case tracklist, type
    }
}

struct AlbumDetail2: Codable {
    let id: Int
    let title: String
    let coverSmall: String
    let coverMedium: String
    let coverBig: String
    let coverXL: String
    let tracklist: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXL = "cover_xl"
        case tracklist
    }
}
