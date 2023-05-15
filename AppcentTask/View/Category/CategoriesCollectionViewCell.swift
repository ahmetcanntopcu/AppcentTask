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
                    self.categoryImageView.image = image
                }
            }.resume()
        } else {
            print("Invalid image URL")
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
    }
    
}
