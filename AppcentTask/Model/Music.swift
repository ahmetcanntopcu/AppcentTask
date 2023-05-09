//
//  Music.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 8.05.2023.
//

import Foundation

struct MusicResponse: Codable {
    let data: [Music]
}

struct Music: Codable {
    let id: Int
    let name: String
    let pictureMedium: String

    
    enum CodingKeys: String, CodingKey {
        case id, name
        case pictureMedium = "picture_medium"
      
    }
}
