
//  ViewController.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var devinetteLabel: UILabel!
    @IBOutlet weak var userInputField: UITextField!
    @IBOutlet weak var userUsedLetters: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var hangmanView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playRound()
    }
    
    func playRound() {
        MovieDownloader.shared.downloadMovie(withID: generateRandomIMDbID()) { (film) in
            JeuPendu.shared.LettresUtilisateurs=[]
            JeuPendu.shared.jouer(avec: film!)
            self.devinetteLabel.text = JeuPendu.shared.devinette
            self.pointsLabel.text = "Pointage: \(JeuPendu.shared.erreurs)"
        }
    }
    
    @IBAction func validateBtn(_ sender: Any) {
        if let res = userInputField.text, res.count == 1 {
            JeuPendu.shared.verifier(lettre: Character(res))
            devinetteLabel.text = JeuPendu.shared.devinette
        }
        userInputField.text = ""
        userUsedLetters.text = JeuPendu.shared.LettresUtilisees
        pointsLabel.text = "Erreurs: \(JeuPendu.shared.erreurs)"
        hangmanView.image = JeuPendu.shared.image
        let my_username = UserDefaults.value(forKey: "username", as: String.self)!
        if let fin = JeuPendu.shared.verifierFinDePartie(username: my_username, gameType: "MovieMode"){
            print("DB Gagné: ", fin)
            let alert = UIAlertController(title: "Fin de partie", message: "\(fin)", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {(_) in
                print("end of game")
                self.playRound()
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func generateRandomIMDbID() -> String {
        let min = 1
        let max = 55252
        let numRandom = Int.random(in: min...max)
        
        return String(format: "tt%07d", numRandom)
    }
    
    
}

