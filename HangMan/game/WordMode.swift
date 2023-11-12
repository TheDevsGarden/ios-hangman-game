//
//  WordMode.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import Foundation
import UIKit
import CoreData

struct EndOfGameInformationWordMode {
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


class WordMode {
    static let shared: WordMode = WordMode()
    var scoresVC: ScoresViewController?

    private init() {}

    private let maxErreur: Int = 7
    private var nbErreurs: Int = 0
    private var motADeviner: [Character] = []
    private var indexTrouves: [Bool] = []
    public var LettresUtilisateurs: [Character] = []

    
    var devinette: String {
            let arr = indexTrouves.indices.map {indexTrouves[$0] ? motADeviner[$0] : "#"}
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
    

    func jouer(avec mot: String){
        motADeviner = Array(mot)
        indexTrouves = Array(repeating: false, count: motADeviner.count)
        motADeviner.enumerated().forEach { (idx, lettre) in
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
            motADeviner.enumerated().forEach { (idx, lettreMystere) in
                if lettreMystere.lowercased() == lettre.lowercased() {
                    indexTrouves[idx] = true
                    trouvee = true
                }
            }

            if !trouvee {
                nbErreurs += 1
            }
        }


    func verifierFinDePartie(username: String, gameType: String) -> String? {
        if nbErreurs >= maxErreur {
            return EndOfGameInformation(win: false, title: String(motADeviner), cntErrors: nbErreurs).finalMessage
        } else if !devinette.contains("#") {
            let score = maxErreur - nbErreurs
            
            let scoresVC = ScoresViewController()
            scoresVC.username = username
            scoresVC.saveScore(gameType: gameType, score: score)
            
            return EndOfGameInformation(win: true, title: String(motADeviner), cntErrors: nbErreurs).finalMessage
        } else {
            return nil
        }
    }
}
