//
//  CategoriesCollectionViewCell.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 9.05.2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    static let identifier = "CategoriesCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the content mode 
        categoryImageView.contentMode = .scaleAspectFit
        
    }
    
    public func configure(with music: Music) {
        self.categoryName.text = music.name
        
        if let url = URL(string: music.pictureMedium) {
            MusicService.fetchImageData(from: url) { result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        let image = UIImage(data: imageData)
                        self.categoryImageView.image = image
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
        return UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
    }
    
}
