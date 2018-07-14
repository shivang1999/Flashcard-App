//
//  ViewController.swift
//  Flashcard App
//
//  Created by Shivang Ranjan on 02/07/18.
//  Copyright © 2018 Shivang Ranjan. All rights reserved.



//Fetch and view existing cards and navigate though the list of cards
//Check to see if there are cards in the database and store results in a list if there are any
//View exisiting cards and navigate through the list of cards - fetching the data the exists
// Delete Old Flashcards that we no longer want
//Randomly select card from the list and display either question and answer
//Swipe up or down to display other side of card
//Swipe right to choose a new card
//Navigate to the card we o longer want and delete it upon the button press( remove from database and from lists of cards0
//variables : listOfCards , currentCard , managedObjectContext, question/answer enumeration
//Functions : fetch cards, choose card, refreshData


//variables : see above
//Functions : deleteCard



import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var CardContentLabel: UILabel!
    
    enum DisplayMode{
        case questionFirst
        case answerFirst
    }
    var currentDisplayMode : DisplayMode = .questionFirst
    var managedObjectContext : NSManagedObjectContext!
    var listOfCards = [FlashCard]()
    var currentCard : FlashCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view, typically from a nib.
        fetchCards()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchCards()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchCards(){
        let fetchRequest : NSFetchRequest<FlashCard> = FlashCard.fetchRequest()
        do {
            listOfCards = try managedObjectContext.fetch(fetchRequest)
            print("flashCards fetched successfully")
            printCards()
        }catch {
            print("Could not fetch data from managed object context")
        }
    }

    
    func printCards(){
        for card in listOfCards {
            print(card.question!)
            print(card.answer!)
        }
    }
    @IBAction func ChooseDisplayModeAction(_    sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            currentDisplayMode = .questionFirst
        case 1 :
            currentDisplayMode = .answerFirst
        default:
            currentDisplayMode = .questionFirst
            
        }
    }
    func displayCard(){
        let randomIndex = Int(arc4random_uniform(UInt32(listOfCards.count)))
        currentCard = listOfCards[randomIndex]
        if let displayCard = currentCard {
            displayQuestionorAnswer(cardToDisplay: displayCard)
        }else{
            CardContentLabel.text = "No cards to display"
        }
    }
    func displayQuestionorAnswer(cardToDisplay card : FlashCard){
        switch currentDisplayMode {
        case .questionFirst:
            CardContentLabel.text = card.question
        case .answerFirst :
            CardContentLabel.text = card.answer
        }
    }
    
    @IBAction func SwipeRightAction(_ sender: UISwipeGestureRecognizer) {
        displayCard()
    }
    
    @IBAction func UprightAction(_ sender: UISwipeGestureRecognizer) {
        if let card = currentCard{
            CardContentLabel.text = card.question
        }
    }
    
    @IBAction func DownAction(_ sender: UISwipeGestureRecognizer) {
        if let card = currentCard{
            CardContentLabel.text = card.answer
        }
    }
    
    @IBAction func DeleteCardAction(_ sender: UIButton) {
        if currentCard == nil {
            return
        } else {
            managedObjectContext.delete(currentCard!)
            
            do {
                try managedObjectContext.save()
                print("FlashCard sucessfully deleted")
                fetchCards()
                displayCard()
            }catch {
                print("FlashCard couldn't be deleted")
            }
        }
    }
    
    
}


