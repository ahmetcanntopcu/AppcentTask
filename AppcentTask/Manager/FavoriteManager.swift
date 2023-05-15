//
//  FavoriteManager.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 15.05.2023.
//

import Foundation

// FavoriteManager.swift

import Foundation

class FavoriteManager {
    static let shared = FavoriteManager() // Singleton instance
    
    static var favoriteSongs: [Song] = [] // Array to store favorite songs
    
    func addToFavorites(song: Song) {
        // Check if the song is already in favorites
        if FavoriteManager.favoriteSongs.contains(where: { $0.id == song.id }) {
            return // Song is already in favorites, no need to add again
        }
        
        FavoriteManager.favoriteSongs.append(song)
    }
    
    func removeFromFavorites(song: Song) {
        FavoriteManager.favoriteSongs.removeAll(where: { $0.id == song.id })
        NotificationCenter.default.post(name: Notification.Name("FavoriteListUpdated"), object: nil)
    }

    
    func isSongLiked(song: Song) -> Bool {
        return FavoriteManager.favoriteSongs.contains(where: { $0.id == song.id })
    }
}
