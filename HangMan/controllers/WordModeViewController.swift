//
//  WordModeViewController.swift
//  IOS_2_TP1
//
//  Created by Ilya Belyaev on 2023-08-24.
//

import UIKit

class WordModeViewController : UIViewController {
    
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
        WordDownloader.shared.downloadWord() {(mot) in
            WordMode.shared.LettresUtilisateurs=[]
            WordMode.shared.jouer(avec: mot!)
            self.devinetteLabel.text = WordMode.shared.devinette
            self.pointsLabel.text = "Pointage: \(WordMode.shared.erreurs)"
        }
    }

    @IBAction func validateBtn(_ sender: Any) {
        if let res = userInputField.text, res.count == 1 {
            WordMode.shared.verifier(lettre: Character(res))
            devinetteLabel.text = WordMode.shared.devinette
        }
        userInputField.text = ""
        userUsedLetters.text = WordMode.shared.LettresUtilisees
        pointsLabel.text = "Erreurs: \(WordMode.shared.erreurs)"
        hangmanView.image = WordMode.shared.image
        let my_username = UserDefaults.value(forKey: "username", as: String.self)!
        if let fin = WordMode.shared.verifierFinDePartie(username: my_username, gameType: "WordMode"){
            print("DB Gagné: ", fin)
            let alert = UIAlertController(title: "Fin de partie", message: "\(fin)", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {(_) in
                //handle response here
                print("end of game")
                self.playRound()
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
