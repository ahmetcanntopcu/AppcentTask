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
                    self.artistImageView.image = image
                }
            }.resume()
        } else {
            print("Invalid image URL")
        }
    }
         

    
    static func nib() -> UINib {
        return UINib(nibName: "ArtistsCollectionViewCell", bundle: nil)
    }

}
