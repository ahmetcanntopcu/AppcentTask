//
//  FavoritesViewController.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 15.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    @IBOutlet weak var favoriteLbl: UILabel!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favoriteSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        
        favoriteLbl.text = "Favorites"
        
        favoriteSongs = FavoriteManager.favoriteSongs
        
    }
    
}

extension FavoritesViewController: UITableViewDelegate {
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        let song = favoriteSongs[indexPath.row]
        cell.configure(with: song)
        
        return cell
    }
    
    
}
