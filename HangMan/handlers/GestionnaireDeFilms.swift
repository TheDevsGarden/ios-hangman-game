//
//  GestionnaireDeFilms.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import Foundation
class MovieDownloader {
    static let shared = MovieDownloader()
    private init() {}
    func downloadMovie(withID id: String, completion: @escaping (Film?) -> Void) {
    
        let urlRef = "https://www.omdbapi.com/?i=\(id)&apikey=6f1474b7"
        guard let url = URL(string: urlRef) else {
            print("Erreur: URL invalide: \(urlRef)")
            return
    }

    let task = URLSession.shared.dataTask(with: url) {
        (data, _, error) in
        if let error = error {
            print("Error: \(error)")
        } else if let data = data {
            let decoder = JSONDecoder()
            do {
                let film = try decoder.decode(Film.self, from: data)
                debugPrint(film)
                DispatchQueue.main.async {
                    completion(film)
                }
                
        }catch {
                    print("Error decoding movie: \(error)")
                    completion(nil)
                }
            }
        }
        task.resume()
    }}
