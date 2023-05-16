//
//  MusicService.swift
//  AppcentTask
//
//  Created by Ahmet Can Topcu on 16.05.2023.
//

import Foundation

struct MusicService {
    
    static func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "DataServiceError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func fetchImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "MusicServiceError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
                completion(.failure(error))
                return
            }
            
            completion(.success(data))
        }.resume()
    }

}

