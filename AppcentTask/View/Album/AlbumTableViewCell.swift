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
            print("burdayımahmet \(album)")
            
            if let url = URL(string: album.coverMedium) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print("Error loading image: \(error.localizedDescription)")
                        return
                    }
                    guard let data = data, let image = UIImage(data: data) else {
                        print("Invalid image data")
                        return
                    }
                    DispatchQueue.main.async {
                        self.albumImageView.image = image
                    }
                }.resume()
            } else {
                print("Invalid image URL")
            }
        }

}
