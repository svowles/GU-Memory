//
//  EasyGameViewController.swift
//  GU Memory
//
//  Created by Sammy on 11/21/18.
//  Copyright © 2018 Sammy. All rights reserved.
//

import UIKit
import GameKit

class EasyGameViewController: UIViewController, GKGameCenterControllerDelegate  {
    
    var cards = [Card]()
    
    //names oc the images to be assigned to the cards
    var images = ["Spike.png", "GULogo.png", "CollegeHall.jpg", "Bulldog.jpeg"]
    
    //to capture the previous button clicked
    @IBOutlet var prevButton: UIButton!
    
    @IBOutlet var scoreLabel: UILabel!
    
    
    var numOfAttempts = 0
    
    var numOfAttemptsLeft = 15
    
    var score = 0
    
    @IBOutlet var card0Button: UIButton!
    
    @IBOutlet var card1Button: UIButton!
    
    @IBOutlet var card2Button: UIButton!
    
    @IBOutlet var card3Button: UIButton!
    
    @IBOutlet var card4Button: UIButton!
    
    @IBOutlet var card5Button: UIButton!
    
    @IBOutlet var card6Button: UIButton!
    
    @IBOutlet var card7Button: UIButton!
    
    /**
     action for if a button is clicked
     */
    @IBAction func cardButtonSelected(sender: UIButton){
        print(cards[sender.tag].backImage)
        sender.setBackgroundImage(UIImage(named: cards[sender.tag].flipCard()), for: .normal)
        sender.isEnabled = false
        print("button selected: \(sender.tag)")
        
        let checkCards = checkForTwoCards()
        if checkCards.found{
            
            //add to attempts variable
            if !checkForMatch(cardMatch: checkCards.indexes){
                sender.setBackgroundImage(UIImage(named: cards[sender.tag].flipCard()), for: .normal)
                prevButton.setBackgroundImage(UIImage(named: cards[prevButton.tag].flipCard()), for: .normal)
                sender.isEnabled = true
                prevButton.isEnabled = true
            }
            else{
                //add to score
                
//                self.score += score * 10
//
//                scoreLabel.text = "Score: \(score)"
            }
            
        
        }
        

        
        prevButton = sender
    }
    
    /**
     checks to see if passed cards are matches and updates isMatched member if they are. returns false otherwise.
     */
    func checkForMatch(cardMatch: [Int]) -> Bool{
        
        if numOfAttemptsLeft > 1 {
            numOfAttemptsLeft -= 1
            
        }
        print("numOfAttempts: \(numOfAttemptsLeft)")
        
        if cards[cardMatch[0]].backImage == cards[cardMatch[1]].backImage {
            cards[cardMatch[0]].isMatched = true
            cards[cardMatch[1]].isMatched = true
            
            print("MATCH")
            
            
            self.score += numOfAttemptsLeft * 10
            
            scoreLabel.text = "Score: \(score)"
            
            print("new score: \(score)")
            
            //check to see if game is over
            
            
            
            
            return true
        }
        return false
    }
    
    /**
     checks to see if two cards are currently flipped. returns true or false if flipped and indexes of the two flipped cards
     */
    func checkForTwoCards() -> (found: Bool, indexes: [Int]){
        var numFlippedCards = 0
        var indexFlipCards = [Int]()
        for i in 0..<cards.count{
            if cards[i].isFlipped && !cards[i].isMatched{
                numFlippedCards += 1
                indexFlipCards.append(i)
            }
            if numFlippedCards == 2{
                return (true, indexFlipCards)
            }
        }
        return (false, [])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create 8 new cards
        for i in 0..<8 {
            let c = Card(frontImage: "", backImage: "")
            cards.append(c)
        }
        setCardImage()
        //randomly assign cards with images
        
        // Do any additional setup after loading the view.
        
        
        //authenticate user in game center
        authenticateCurrentPlayer()
    }
    
    /**
     function to randomly assign images to the cards so that the same image in on 2 cards and all cards have images
     */
    func setCardImage(){
        //array of random numbers already chosen (aka card indexes already set)
        var usedRandomNumber = [Int]()
        //index of image array (aka the index of the image we are assigning to a card)
        var j = 0
        
        //for loop to go through each card in the cards array
        for i in 0..<cards.count{
            //start out with a non valid num to enter the loop
            var validNum = false
            
            //while we are picking a random number (aka already assigned card) we need to pick a new random number
            while(!validNum){
                //pick random number between 0 and card count (aka pick random index in the cards array)
                var randNum = Int.random(in: 0..<cards.count)
                //if it's a card we havent assigned yet, assign an image to the card and add the randNum to the used number array
                print(randNum)
                if !usedRandomNumber.contains(randNum){
                    print(images[j])
                    cards[randNum].backImage = images[j]
                    usedRandomNumber.append(randNum)
                    //we picked a valid num, so get out of loop
                    validNum = true
                }
                else{
                    //we didn't pick a valid num, keep going in loop
                    validNum = false
                }
            }
            
            //every other iteratio, increment the index for the images array (the same image gets assigned twivce in a row before moving on to the next image)
            if i % 2 != 0{
                j+=1
            }
        }
        
    }
    
    
    func isGameOver() -> Bool {
        for c in cards {
            if c.isMatched == false{
                 return false
            }
        }
        return true
    }
    
    
    func authenticateCurrentPlayer() {
        let localPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = {(view, error) in
            if let currentView = view {
                self.present(view!, animated: true, completion: nil)
            }
            else{
                print(GKLocalPlayer.local.isAuthenticated)
            }
        }
    }
    
}
