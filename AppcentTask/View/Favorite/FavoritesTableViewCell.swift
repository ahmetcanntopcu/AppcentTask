//
//  FavoritesTableViewCell.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 15.05.2023.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteSongLbl: UILabel!
    @IBOutlet weak var favoriteDurationLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    var currentSong: Song?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        favoriteBtn.tintColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with song: Song) {
        // Configure the cell with the song details
        
        currentSong = song
        favoriteSongLbl.text = song.title
        
        let songDuration = song.duration // Şarkı süresi (saniye cinsinden)
        let minutes = songDuration / 60
        let seconds = songDuration % 60
        let formattedDuration = String(format: "%02d:%02d", minutes, seconds)
        favoriteDurationLbl.text = formattedDuration
        
        if let url = URL(string: AlbumDetailViewController.imageUrl) {
            MusicService.fetchImageData(from: url) { result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        self.favoriteImageView.image = image
                    }
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        } else {
            print("Invalid image URL")
        }
    }
    
    @IBAction func favoriteBtnClicked(_ sender: UIButton) {
        guard let song = currentSong else {
            return
        }
        
        sender.tintColor = .lightGray
        
        if FavoriteManager.shared.isSongLiked(song: song) {
            FavoriteManager.shared.removeFromFavorites(song: song)
            NotificationCenter.default.post(name: Notification.Name("FavoriteListUpdated"), object: nil)
        }
    }
    
}
