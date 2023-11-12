//
//  PreferencesController.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

// import Foundation
// import UIKit
// class PreferencesController: UIViewController {


//     @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
//     @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
//     @IBOutlet weak var CurrentPreferences: UILabel!
    
//     let languageOptions = ["FR", "EN"]
//     let themeOptions = ["Light", "Dark"]
    
//     override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
        
//         if let language = UserDefaults.standard.string(forKey: "userLanguage") {
//             languageSegmentedControl.selectedSegmentIndex = languageOptions.firstIndex(of: language) ?? 0
//         }
        
//         if let theme = UserDefaults.standard.string(forKey: "userTheme") {
//             themeSegmentedControl.selectedSegmentIndex = themeOptions.firstIndex(of: theme) ?? 0
//         }
//     }
    
//     @IBAction func languageSegmentedControlValueChanged(_ sender: UISegmentedControl) {
//         let selectedLanguage = languageOptions[sender.selectedSegmentIndex]
//         // UserDefaults.standard.set(selectedLanguage, forKey: "userLanguage")
//         UserDefaults.set(selectedLanguage, forKey: "userLanguage", as: String.self)
//     }
    
//     @IBAction func themeSegmentedControlValueChanged(_ sender: UISegmentedControl) {
//         let selectedTheme = themeOptions[sender.selectedSegmentIndex]
//         // UserDefaults.standard.set(selectedTheme, forKey: "userTheme")
//         UserDefaults.set(selectedTheme, forKey: "userTheme", as: String.self)
//     }
    
//     func getLangue() -> String{
//         return UserDefaults.value(forKey: "userLanguage", as: String.self) ?? ""
//     }
    
//     func getTheme() -> String{
//         return UserDefaults.value(forKey: "userTheme", as: String.self) ?? ""
//     }
    
//     var currentPrefs = """
//         Les Préférneces courantes sont:
//         Langue: \(getLangue())
//         Theme: \(getTheme())
        
//         """
    
// }
import Foundation
import UIKit

class PreferencesController: UIViewController {
    
    struct CurrentPreferences {
        let language: String
        let theme: String
        
        var message: String {
            return """
                Current Preferences:
                Language: \(language)
                Theme: \(theme)
                """
        }
    }

    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var currentPreferencesLabel: UILabel!
    
    let languageOptions = ["FR", "EN"]
    let themeOptions = ["Light", "Dark"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set("FR", forKey: "userLanguage");
        UserDefaults.standard.set("Light", forKey: "userTheme");
        
        if let language = UserDefaults.standard.string(forKey: "userLanguage") {
            languageSegmentedControl?.selectedSegmentIndex = languageOptions.firstIndex(of: language) ?? 0
        }
        
        if let theme = UserDefaults.standard.string(forKey: "userTheme") {
            themeSegmentedControl?.selectedSegmentIndex = themeOptions.firstIndex(of: theme) ?? 0
        }
        
        updateCurrentPreferencesLabel()
    }
    
    @IBAction func languageSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedLanguage = languageOptions[sender.selectedSegmentIndex]
        UserDefaults.standard.set(selectedLanguage, forKey: "userLanguage")
        updateCurrentPreferencesLabel()
    }

    @IBAction func themeSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedTheme = themeOptions[sender.selectedSegmentIndex]
        UserDefaults.standard.set(selectedTheme, forKey: "userTheme")
        updateCurrentPreferencesLabel()
    }
    
    func getLanguage() -> String {
        return UserDefaults.value(forKey: "userLanguage", as: String.self) ?? ""
    }
    
    func getTheme() -> String {
        return UserDefaults.value(forKey: "userTheme", as: String.self) ?? ""
    }
    
    func updateCurrentPreferencesLabel() {
        let currentPrefs = CurrentPreferences(language: getLanguage(), theme: getTheme())
        currentPreferencesLabel?.text = currentPrefs.message
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    
}
