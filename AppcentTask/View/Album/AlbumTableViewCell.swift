//
//  AlbumTableViewCell.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 15.05.2023.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var albumNameLbl: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    var tracks: [Track] = []
    var albumDetail: [AlbumDetail] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    public func configure(with track: Track) {
        
            albumNameLbl.text = track.album.title
            let album = track.album
            
            if let url = URL(string: album.coverMedium) {
                MusicService.fetchImageData(from: url) { result in
                    switch result {
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData)
                            self.albumImageView.image = image
                        }
                    case .failure(let error):
                        print("Error loading image: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Invalid image URL")
            }
        }

}
