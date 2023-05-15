//
//  FavoriteSong.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 15.05.2023.
//

import Foundation

struct FavoriteSong: Codable {
    let songID: Int
    let songTitle: String
    var isLiked: Bool
}
