//
//  AlbumDetailTableViewCell.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 15.05.2023.
//

import UIKit

class AlbumDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var songNameLbl: UILabel!
    @IBOutlet weak var songDurationLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var songImageView: UIImageView!
    
    var imageUrl = ""
    private var currentSong: Song?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        likeBtn.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configure(with song: Song, with urlImg: String) {
        currentSong = song
        songNameLbl.text = String(song.title)
        let songDuration = song.duration
        let minutes = songDuration / 60
        let seconds = songDuration % 60
        let formattedDuration = String(format: "%02d:%02d", minutes, seconds)
        songDurationLbl.text = formattedDuration

            
        if let url = URL(string: urlImg) {
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
                        self.songImageView.image = image
                    }
                }.resume()
            } else {
                print("Invalid image URL")
            }
        likeBtn.isSelected = FavoriteManager.shared.isSongLiked(song: song)
    }

    @IBAction func likeBtnClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        guard let song = currentSong else {
            return
        }
        
        if sender.isSelected {
            // Add to favorites
            FavoriteManager.shared.addToFavorites(song: song)
            let filledHeartImage = UIImage(named: "heart.filled")?.withRenderingMode(.alwaysTemplate)
            sender.setImage(filledHeartImage, for: .selected)
            sender.tintColor = .red // Set the fill color of the heart button
        } else {
            // Remove from favorites
            FavoriteManager.shared.removeFromFavorites(song: song)
            let emptyHeartImage = UIImage(named: "heart_empty")?.withRenderingMode(.alwaysTemplate)
            sender.setImage(emptyHeartImage, for: .normal)
            sender.tintColor = .lightGray // Set the fill color of the heart button
        }
    }

    
}
