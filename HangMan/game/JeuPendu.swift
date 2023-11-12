//
//  JeuPendu.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import Foundation
import UIKit
struct EndOfGameInformation {


    let win: Bool
    let title: String
    let cntErrors: Int
    var finalMessage: String {
        return """
                win: \(win) in \(cntErrors) / 7.

                Title was :
                \(title)
                """
    }
}

class JeuPendu {
    static let shared: JeuPendu = JeuPendu()
    var scoresVC: ScoresViewController?

    private init() {}

    private let maxErreur: Int = 7
    private var nbErreurs: Int = 0
    private var titreADeviner: [Character] = []
    private var indexTrouves: [Bool] = []
    public var LettresUtilisateurs: [Character] = []
    private var filmADeviner: Film?

    
    var devinette: String {
            let arr = indexTrouves.indices.map {indexTrouves[$0] ? titreADeviner[$0] : "#"}
            return String(arr)
        }

    var LettresUtilisees: String {
        return Array(LettresUtilisateurs).map {String($0)}.joined(separator: ", ")
    }

    var erreurs: String {
        return "\(nbErreurs) / \(maxErreur)"
    }

    var image: UIImage {
            return UIImage(named: imageNamesSequence[nbErreurs])!
        }

    func jouer(avec film: Film){
        filmADeviner = film
        titreADeviner = Array(film.Title)
        indexTrouves = Array(repeating: false, count: titreADeviner.count)
        titreADeviner.enumerated().forEach { (idx, lettre) in
            if !("abcdefghijklmnopqrstuvwxyz").contains(lettre.lowercased()) {
                indexTrouves[idx] = true
            }
        }

        print("DB: jouer()", devinette)
        nbErreurs = 0
    }

    
    func verifier(lettre: Character) {
            LettresUtilisateurs.append(lettre)
            var trouvee = false
            titreADeviner.enumerated().forEach { (idx, lettreMystere) in
                if lettreMystere.lowercased() == lettre.lowercased() {
                    indexTrouves[idx] = true
                    trouvee = true
                }
            }

            if !trouvee {
                nbErreurs += 1
            }
        }
    
    func afficherHint() -> String {
        var hint: String = ""
        if let film = filmADeviner {
            hint += "Année de sortie: \(film.Year)\n"
            hint += "Genre: \(film.Genre)\n"
            hint += "Directeur: \(film.Director)\n"
            hint += "Acteurs: \(film.Actors)\n"
            hint += "Ratings: "
            film.Ratings.forEach { (rating) in
                hint += "\(rating.Source): \(rating.Value)\n"
            }
        }
        return hint
    }

func verifierFinDePartie(username: String, gameType: String) -> String? {
        if nbErreurs >= maxErreur {
            return EndOfGameInformation(win: false, title: String(titreADeviner), cntErrors: nbErreurs).finalMessage
        } else if !devinette.contains("#") {
            let score = maxErreur - nbErreurs
            
            let scoresVC = ScoresViewController()
            scoresVC.username = username
            scoresVC.saveScore(gameType: gameType, score: score)
            
            return EndOfGameInformation(win: true, title: String(titreADeviner), cntErrors: nbErreurs).finalMessage
        } else {
            return nil
        }
    }


}


