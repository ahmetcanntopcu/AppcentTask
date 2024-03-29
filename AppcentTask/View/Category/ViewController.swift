//
//  ViewController.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 8.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var musics: [Music] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        categoriesCollectionView.collectionViewLayout = layout
        
        categoriesCollectionView.register(CategoriesCollectionViewCell.nib(), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        
        // Call the api
        let url = URL(string: "https://api.deezer.com/genre")!
        MusicService.fetchData(from: url) { (result: Result<MusicResponse, Error>) in
            switch result {
            case .success(let response):
                self.musics = response.data
                
                DispatchQueue.main.async {
                    self.categoriesCollectionView.reloadData()
                }
            case .failure(let error):
                // Handle the error
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let artistViewController = storyboard.instantiateViewController(withIdentifier: "ArtistViewController") as! ArtistViewController
        artistViewController.selectedCategoryID = musics[indexPath.row].id
        artistViewController.titleLabel = musics[indexPath.row].name

        // Push the new view controller onto the navigation stack
        if let navigationController = self.navigationController {
            navigationController.pushViewController(artistViewController, animated: true)
        }
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        let music = musics[indexPath.row]
        cell.configure(with: music)
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
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
 

