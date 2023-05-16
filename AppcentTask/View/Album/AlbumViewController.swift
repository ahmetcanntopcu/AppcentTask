//
//  AlbumViewController.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 12.05.2023.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var artistImg: UIImageView!
    @IBOutlet weak var albumTableView: UITableView!
    
    
    var selectedArtistId: Int = 0
    var artistName: String?
    var tracks: [Track] = []
    var tracklistUrl: String?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        artistNameLbl.text = artistName
        albumTableView.dataSource = self
        albumTableView.delegate = self
        
        // Call the API with selected category ID
        let artistId = selectedArtistId
        let url = URL(string: "https://api.deezer.com/artist/\(artistId)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                // Decode the JSON response
                let decoder = JSONDecoder()
                let response = try? decoder.decode(Album.self, from: data)
               
                if let response = response {
                    if let url = URL(string: response.pictureXL) {
                        MusicService.fetchImageData(from: url) { result in
                            switch result {
                            case .success(let imageData):
                                DispatchQueue.main.async {
                                    let image = UIImage(data: imageData)
                                    self.artistImg.image = image
                                }
                            case .failure(let error):
                                print("Error loading image: \(error.localizedDescription)")
                            }
                        }
                    }
                    
                    
                }
            } catch {
                print("Error decoding response: \(error.localizedDescription)")
            }
        }.resume()
        
        let urlSecond = URL(string: "https://api.deezer.com/artist/\(artistId)/top?limit=50")!
        MusicService.fetchData(from: urlSecond) { (result: Result<TrackResponse, Error>) in
            switch result {
            case .success(let response):
                self.tracks = response.data
                
                DispatchQueue.main.async {
                    self.albumTableView.reloadData()
                }
            case .failure(let error):
                // Handle the error
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }

}

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let albumDetailViewController = storyboard.instantiateViewController(withIdentifier: "AlbumDetailViewController") as! AlbumDetailViewController
        albumDetailViewController.selectedAlbumId = tracks[indexPath.row].album.id
        albumDetailViewController.albumName = tracks[indexPath.row].album.title

        // Push the new view controller onto the navigation stack
        if let navigationController = self.navigationController {
            navigationController.pushViewController(albumDetailViewController, animated: true)
        }

    }
    
}
extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as! AlbumTableViewCell
        let track = tracks[indexPath.row]
        cell.configure(with: track)
        return cell
    }
    
    
}






