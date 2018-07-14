//
//  FlashCardViewController.swift
//  Flashcard App
//
//  Created by Shivang Ranjan on 02/07/18.
//  Copyright © 2018 Shivang Ranjan. All rights reserved.
// Create FlashCards and save them to a database
// Retrieve question and answer texts and save it to the database
//variables: currentCard, managedObjectContext
//fucntions we might need: Save Card To Database




import UIKit
import CoreData

class FlashCardViewController: UIViewController {
    
    @IBOutlet weak var QuestiontextView: UITextView!
    @IBOutlet weak var AnswerTextView: UITextView!
    
    var managedObjectContext : NSManagedObjectContext!  //manages saving, fetching and deleting functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SaveCardAction(_ sender: UIButton) {
        guard let question = QuestiontextView.text else {
            return
        }
        guard let answer = AnswerTextView.text else {
            return
        }
        SaveCardToDatabase(question: question , answer: answer)
    }
    
    func SaveCardToDatabase(question : String, answer : String ){
        let newFlashCard = NSEntityDescription.insertNewObject(forEntityName: "FlashCard", into: managedObjectContext) as! FlashCard
        newFlashCard.question = question
        newFlashCard.answer = answer
        
        do{
            try managedObjectContext.save()
            print("flashcard saved sucessfully")
        }catch{
            print("Couldnot save managedObjectContext state, flashcard not saved" )
        }
    }
}
