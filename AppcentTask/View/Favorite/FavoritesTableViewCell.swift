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
        currentSong = song
        // Configure the cell with the song details
        favoriteSongLbl.text = song.title
        let songDuration = song.duration // Şarkı süresi (saniye cinsinden)
        let minutes = songDuration / 60
        let seconds = songDuration % 60
        let formattedDuration = String(format: "%02d:%02d", minutes, seconds)
        favoriteDurationLbl.text = formattedDuration
        if let url = URL(string: AlbumDetailViewController.imageUrl) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                print(url)
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    return
                }
                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid image data")
                    return
                }
                DispatchQueue.main.async {
                    self.favoriteImageView.image = image
                }
            }.resume()
        } else {
            print("Invalid image URL")
        }
        // Set the appropriate image for the like button based on the song's liked status
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
