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
        MusicService.fetchData(from: url) { (result: Result<ArtistResponse, Error>) in
            switch result {
            case .success(let response):
                self.artists = response.data
                
                DispatchQueue.main.async {
                    self.artistCollectionView.reloadData()
                }
            case .failure(let error):
                // Handle the error
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
}

extension ArtistViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let albumViewController = storyboard.instantiateViewController(withIdentifier: "AlbumViewController") as! AlbumViewController
        albumViewController.selectedArtistId = artists[indexPath.row].id
        albumViewController.artistName = artists[indexPath.row].name

        // Push the new view controller onto the navigation stack
        if let navigationController = self.navigationController {
            navigationController.pushViewController(albumViewController, animated: true)
        }
    }
     
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
