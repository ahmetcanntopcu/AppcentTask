//
//  AlbumDetailViewController.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 15.05.2023.
//

import UIKit
import AVFoundation

class AlbumDetailViewController: UIViewController {
    
    @IBOutlet weak var albumTitleLbl: UILabel!
    @IBOutlet weak var albumDetailTableView: UITableView!
    
    
    var selectedAlbumId = 0
    var albumName: String = ""
    var songs: [Song] = []
    static var imageUrl = ""
    var currentPlayingPlayer: AVPlayer?
    var currentPlayingIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumDetailTableView.dataSource = self
        albumDetailTableView.delegate = self

        albumTitleLbl.text = albumName
        
        let url = URL(string: "https://api.deezer.com/album/\(selectedAlbumId)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                // Decode the JSON response
                let decoder = JSONDecoder()
                let response = try? decoder.decode(AlbumDetail2.self, from: data)
               
                if let response = response {
                    AlbumDetailViewController.imageUrl = response.coverMedium
                    if let urlSecond = URL(string: "https://api.deezer.com/album/\(self.selectedAlbumId)/tracks") {
                        MusicService.fetchData(from: urlSecond) { (result: Result<SongResponse, Error>) in
                            switch result {
                            case .success(let response):
                                self.songs = response.data
                                
                                DispatchQueue.main.async {
                                    self.albumDetailTableView.reloadData()
                                }
                            case .failure(let error):
                                // Handle the error
                                print("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            } catch {
                print("Error decoding response: \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
    @IBAction func favoriteBtnClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let favoritesDetailViewController = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        

        // Push the new view controller onto the navigation stack
        if let navigationController = self.navigationController {
            navigationController.pushViewController(favoritesDetailViewController, animated: true)
        }
    }
    
}

extension AlbumDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSong = songs[indexPath.row]
        if let url = URL(string: selectedSong.preview) {
            let playerItem = AVPlayerItem(url: url)
            let player = AVPlayer(playerItem: playerItem)
                    
            if indexPath == currentPlayingIndexPath {
                // User clicked on the same song, stop playback
                currentPlayingPlayer?.pause()
                currentPlayingPlayer = nil
                currentPlayingIndexPath = nil
            } else {
                // User clicked on a different song, update playback
                // Pause the current player if there is one
                currentPlayingPlayer?.pause()
                        
                // Assign the new player as the current playing player
                currentPlayingPlayer = player
                currentPlayingIndexPath = indexPath
                        
                player.play()
                        
                // Schedule a timer to stop the player after 30 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                    player.pause()
                }
            }
        } else {
            print("Invalid preview URL")
        }
                
        // Deselect the selected row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AlbumDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumDetailTableView.dequeueReusableCell(withIdentifier: "AlbumDetailTableViewCell", for: indexPath) as! AlbumDetailTableViewCell
        let song = songs[indexPath.row]
        cell.configure(with: song, with: AlbumDetailViewController.imageUrl)
        
        return cell
    }

}

