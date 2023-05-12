//
//  ArtistViewController.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 11.05.2023.
//

import UIKit

class ArtistViewController: UIViewController {
    
    
    @IBOutlet weak var artistCollectionView: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var artists: [Artist] = []
    var selectedCategoryID: Int = 0
    var titleLabel = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = titleLabel
        
        let layout = UICollectionViewFlowLayout()
        artistCollectionView.collectionViewLayout = layout
        
        artistCollectionView.register(ArtistsCollectionViewCell.nib(), forCellWithReuseIdentifier: ArtistsCollectionViewCell.identifier)
        artistCollectionView.dataSource = self
        artistCollectionView.delegate = self
        
                
        // Call the API with selected category ID
        let categoryId = selectedCategoryID
        let url = URL(string: "https://api.deezer.com/genre/\(categoryId)/artists")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                // Decode the JSON response
                let decoder = JSONDecoder()
                let response = try? decoder.decode(ArtistResponse.self, from: data)
                if let response = response {
                    self.artists = response.data
                }
                        
                DispatchQueue.main.async {
                    self.artistCollectionView.reloadData()
                }
            } catch {
                print("Error decoding response: \(error.localizedDescription)")
            }
        }.resume()
        

        
    }
    

}

extension ArtistViewController: UICollectionViewDelegate {
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artist = artists[indexPath.row]
        let artistDetailVC = ArtistDetailViewController(artistId: artist.id)
        navigationController?.pushViewController(artistDetailVC, animated: true)
    }
     */
    
}

extension ArtistViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = artistCollectionView.dequeueReusableCell(withReuseIdentifier: ArtistsCollectionViewCell.identifier, for: indexPath) as! ArtistsCollectionViewCell
        let artist = artists[indexPath.row]
        cell.configure(with: artist)
        return cell
    }
    
}

extension ArtistViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
    
}