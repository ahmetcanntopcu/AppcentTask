//
//  Song.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 15.05.2023.
//

import Foundation

struct SongResponse: Codable {
    let data: [Song]
}

struct Song: Codable {
    let id: Int
    let title: String
    let duration: Int
    let preview: String

    enum CodingKeys: String, CodingKey {
        case id, title, duration, preview
       
      
    }
}
