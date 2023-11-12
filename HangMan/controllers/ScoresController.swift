//
//  ScoresController.swift
//  HangMan
//
//  Created by Ilya Belyaev on 2023-09-14.
//

import Foundation
import UIKit
import CoreData


class ScoresViewController: UIViewController {
    var scores: [NSManagedObject] = []
    var username: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scores"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Score")
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 5
        
        do {
            scores = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    func saveScore(gameType: String, score: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND gameType == %@", argumentArray: [username ?? "", gameType])
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if let existingScore = results.first as? NSManagedObject {
                let currentScore = existingScore.value(forKey: "score") as? Int ?? 0
                existingScore.setValue(currentScore + score, forKey: "score")
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "Score", in: managedContext)!
                let scoreObject = NSManagedObject(entity: entity, insertInto: managedContext)
                scoreObject.setValue(username, forKeyPath: "username")
                scoreObject.setValue(gameType, forKeyPath: "gameType")
                scoreObject.setValue(score, forKeyPath: "score")
                scores.append(scoreObject)
            }
            
            try managedContext.save()
            if let tableView = tableView {
                tableView.reloadData()
            }        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }}
extension ScoresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let score = scores[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let username = score.value(forKeyPath: "username") as? String ?? ""
        let gameType = score.value(forKeyPath: "gameType") as? String ?? ""
        let scoreValue = score.value(forKeyPath: "score") as? Int ?? 0
        cell.textLabel?.text = "\(username) - \(gameType): \(scoreValue)"
        return cell
    }
}

func deleteAllScores() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Score")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
        try managedContext.execute(deleteRequest)
        try managedContext.save()
    } catch let error as NSError {
        print("Could not delete. \(error), \(error.userInfo)")
    }
}
