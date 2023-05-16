//
//  ArtistsCollectionViewCell.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 11.05.2023.
//

import UIKit

class ArtistsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistLbl: UILabel!
    
    static let identifier = "ArtistsCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the content mode
         artistImageView.contentMode = .scaleAspectFit
    }
    
    public func configure(with artist: Artist) {
        self.artistLbl.text = artist.name
        
        if let url = URL(string: artist.pictureMedium) {
            MusicService.fetchImageData(from: url) { result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        self.artistImageView.image = image
                    }
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        } else {
            print("Invalid image URL")
        }
    }


    
    static func nib() -> UINib {
        return UINib(nibName: "ArtistsCollectionViewCell", bundle: nil)
    }

}
