//
//  GestionnaireDeMotDeDictionnaire.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import Foundation
class WordDownloader {
    static let shared = WordDownloader()
    
    private init() {}
    
    func downloadWord(completion: @escaping (String?) -> Void) {
        let urlRef = "https://random-word-api.herokuapp.com/word?lang=en"
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
                    let word = try decoder.decode([String].self, from: data)
                    debugPrint(word)
                    DispatchQueue.main.async {
                        completion(word[0])
                    }
                    
                }catch {
                    print("Error decoding word: \(error)")
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
