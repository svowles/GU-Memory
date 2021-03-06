//
//  HardGameViewController.swift
//  GU Memory
//
//  Created by Sammy on 11/21/18.
//  Copyright © 2018 Sammy. All rights reserved.
//

import UIKit
import GameKit
class HardGameViewController: UIViewController {
    
    var cards = [Card]()
    
    //names oc the images to be assigned to the cards
    var images = ["Spike.png", "GULogo.png", "CollegeHall.jpg", "Bulldog.jpeg", "hoop.jpg", "cheer.jpg", "coach.jpg", "campus.jpg", "campus2.jpg", "SpikeMascot.jpg", "church.jpg", "mansion.jpg" , "Students.jpg", "team.jpg" , "goZags.jpg", "player.png"]
    
    
    //to capture the previous button clicked
    @IBOutlet var prevButton: UIButton!
    
    @IBOutlet var scoreLabel: UILabel!
    
    var timer: Timer? = nil
    
    var numOfAttempts = 0
    
    var numOfAttemptsLeft = 50
    
    var score = 0
    
    var backColor: UIColor? = nil
    
    @IBOutlet var card0Button: UIButton!
    
    @IBOutlet var card1Button: UIButton!
    
    @IBOutlet var card2Button: UIButton!
    
    @IBOutlet var card3Button: UIButton!
    
    @IBOutlet var card4Button: UIButton!
    
    @IBOutlet var card5Button: UIButton!
    
    @IBOutlet var card6Button: UIButton!
    
    @IBOutlet var card7Button: UIButton!
    
    @IBOutlet var card8Button: UIButton!
    
    @IBOutlet var card9Button: UIButton!
    
    @IBOutlet var card10Button: UIButton!
    
    @IBOutlet var card11Button: UIButton!
    
    @IBOutlet var card12Button: UIButton!
    
    @IBOutlet var card13Button: UIButton!
    
    @IBOutlet var card14Button: UIButton!
    
    @IBOutlet var card15Button: UIButton!
    
    @IBOutlet var card16Button: UIButton!
    
    @IBOutlet var card17Button: UIButton!
    
    @IBOutlet var card18Button: UIButton!
    
    @IBOutlet var card19Button: UIButton!
    
    @IBOutlet var card20Button: UIButton!
    
    @IBOutlet var card21Button: UIButton!
    
    @IBOutlet var card22Button: UIButton!
    
    @IBOutlet var card23Button: UIButton!
    
    @IBOutlet var card24Button: UIButton!
    
    @IBOutlet var card25Button: UIButton!
    
    @IBOutlet var card26Button: UIButton!
    
    @IBOutlet var card27Button: UIButton!
    
    @IBOutlet var card28Button: UIButton!
    
    @IBOutlet var card29Button: UIButton!
    
    @IBOutlet var card30Button: UIButton!
    
    @IBOutlet var card31Button: UIButton!
    
    
    
    var buttons = [UIButton]()
    
    /**
     action for if a button is clicked
     */
    @IBAction func cardButtonSelected(sender: UIButton){
        print(cards[sender.tag].backImage)
        
        
        UIView.transition(with: sender, duration: 0.3, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
        
        backColor = sender.backgroundColor
        
        sender.backgroundColor = UIColor(named: "white")
        sender.backgroundImage(for: .normal)
        
        print("image after flipped: \(cards[sender.tag].displayedImage)")
        
        let imageAfterFlip = cards[sender.tag].flipCard()
        
        print("image after flipped: \(cards[sender.tag].displayedImage)")
        
        //buttons[i].backgroundColor = self.backColor!
        print("Setting color to \(backColor!)")
        sender.setBackgroundImage(UIImage(named: cards[sender.tag].displayedImage), for: .normal)
        
        /*
        //print("background color: \(sender.backgroundColor)")
        sender.backgroundColor = UIColor(named: "white")
        sender.backgroundImage(for: .normal)
        sender.setBackgroundImage(UIImage(named: cards[sender.tag].flipCard()), for: .normal)
         */
 
        //sender.setImage(UIImage(named: cards[sender.tag].flipCard()), for: .normal)
        sender.isEnabled = false
        sender.adjustsImageWhenDisabled = false
        
        //sender.backgroundImage(for: .normal)
        
        //sender.adjustsImageWhenHighlighted = NO;
        
        
        print("button selected: \(sender.tag)")
        
        let checkCards = checkForTwoCards()
        if checkCards.found{
            
            //add to attempts variable
            if !checkForMatch(cardMatch: checkCards.indexes){
                
                
                self.disableAllButtons()
                
                print("timer starting")
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {(timer) -> Void in
                    /*
                     var sendImage = self.cards[sender.tag].flipCard()
                     var prevImage = self.cards[self.prevButton.tag].flipCard()
                     
                     print("prevImage: \(prevImage)")
                     print("sendImage: \(sendImage)")
                     
                     sender.setBackgroundImage(UIImage(named: sendImage), for: .normal)
                     self.prevButton.setBackgroundImage(UIImage(named: prevImage), for: .normal)
                     
                     */
                    sender.isEnabled = true
                    self.prevButton.isEnabled = true
                    
                    print("turn 2 cards back over")
                    
                    self.turnOverAllNonMatches()
                    
                    self.enableAllNonMatches()
                    
                    print("timer ending")
                    
                    
                    sender.backgroundColor = self.backColor!
                    
                    self.prevButton.backgroundColor = self.backColor!
                    
                })
                /*
                 sender.setBackgroundImage(UIImage(named: cards[sender.tag].flipCard()), for: .normal)
                 prevButton.setBackgroundImage(UIImage(named: cards[prevButton.tag].flipCard()), for: .normal)
                 sender.isEnabled = true
                 prevButton.isEnabled = true
                 
                 print("turn 2 cards back over")
                 
                 */
                
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
            
            scoreLabel.text = "Score: \(self.score)"
            
            print("new score: \(score)")
            
            //check to see if game is over
            if isGameOver() {
                print("GAME OVER")
                
                let alertControllerNotValidInput = UIAlertController(title: "GAME OVER", message: "You scored \(score) points.", preferredStyle: .alert)
                
                alertControllerNotValidInput.addAction(UIAlertAction(title: "New Game", style: .default, handler: { (action) in
                    print("NEW GAME")
                    self.newGame()
                    
                }))
                
                present(alertControllerNotValidInput, animated: true, completion: nil)
                
            }
            
            
            
            
            
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
        for i in 0..<32 {
            let c = Card(frontImage: "", backImage: "")
            cards.append(c)
        }
        setCardImage()
        //randomly assign cards with images
        
        // Do any additional setup after loading the view.
        
        buttons = [card0Button, card1Button, card2Button, card3Button, card4Button, card5Button, card6Button, card7Button, card8Button, card9Button, card10Button, card11Button, card12Button, card13Button, card14Button, card15Button,card16Button, card17Button, card18Button, card19Button, card20Button, card21Button, card22Button, card23Button, card24Button, card25Button, card26Button, card27Button, card28Button, card29Button, card30Button, card31Button]
        
        card0Button.layer.cornerRadius = 10
        card1Button.layer.cornerRadius = 10
        card2Button.layer.cornerRadius = 10
        card3Button.layer.cornerRadius = 10
        card4Button.layer.cornerRadius = 10
        card5Button.layer.cornerRadius = 10
        card6Button.layer.cornerRadius = 10
        card7Button.layer.cornerRadius = 10
        card8Button.layer.cornerRadius = 10
        card9Button.layer.cornerRadius = 10
        card10Button.layer.cornerRadius = 10
        card11Button.layer.cornerRadius = 10
        card12Button.layer.cornerRadius = 10
        card13Button.layer.cornerRadius = 10
        card14Button.layer.cornerRadius = 10
        card15Button.layer.cornerRadius = 10
        card16Button.layer.cornerRadius = 10
        card17Button.layer.cornerRadius = 10
        card18Button.layer.cornerRadius = 10
        card19Button.layer.cornerRadius = 10
        card20Button.layer.cornerRadius = 10
        card21Button.layer.cornerRadius = 10
        card22Button.layer.cornerRadius = 10
        card23Button.layer.cornerRadius = 10
        card24Button.layer.cornerRadius = 10
        card25Button.layer.cornerRadius = 10
        card26Button.layer.cornerRadius = 10
        card27Button.layer.cornerRadius = 10
        card28Button.layer.cornerRadius = 10
        card29Button.layer.cornerRadius = 10
        card30Button.layer.cornerRadius = 10
        card31Button.layer.cornerRadius = 10
        
        //authenticate user in game center
        authenticateCurrentPlayer()
        
        /*
        //show rules
        let alertControllerNotValidInput = UIAlertController(title: "Game Rules", message: "Rules.", preferredStyle: .alert)
        
        alertControllerNotValidInput.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
        
        present(alertControllerNotValidInput, animated: true, completion: nil)
 
        */
 
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
                let randNum = Int.random(in: 0..<cards.count)
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
    
    func newGame(){
        turnOverAllCards()
        
        score = 0
        numOfAttemptsLeft = 15
        setCardImage()
        
        
        
        for i in 0..<buttons.count{
            
            
            
            
            UIView.animate(withDuration: 2.0, animations: {
                //let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                let rotateTransform = CGAffineTransform(rotationAngle: .pi)
                let translateTransform = CGAffineTransform(translationX:
                    0, y: 0)
                let comboTransform = rotateTransform.concatenating(translateTransform)
                        
                self.buttons[i].transform = comboTransform}) { (_) in
                    
                    UIView.animate(withDuration: 2.0, animations: {
                        self.buttons[i].transform = CGAffineTransform.identity
                    })
            }
        }
        
        
        for i in 0..<cards.count {
            cards[i].isMatched = false
            //checkForMatch(cardMatch: <#T##[Int]#>)
            
            scoreLabel.text = "Score: \(score)"
        }
        
        for i in 0..<buttons.count{
            
            buttons[i].isEnabled = true
            buttons[i].backgroundImage(for: .normal)
            
            buttons[i].setBackgroundImage(UIImage(named: cards[i].flipCard()), for: .normal)
            
            buttons[i].backgroundColor = self.backColor!
        }
        
        
    }
    
    func turnOverAllCards(){
        for i in 0..<cards.count {
            
            if cards[i].isFlipped == true {
                print("TURNING OVER")
                
                UIView.transition(with: buttons[i], duration: 0.3, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
                
                
            }
            
        }
    }
    
    func turnOverAllNonMatches(){
        for i in 0..<cards.count {
            
            //if the card has been flipped over but does not have a match
            if cards[i].isFlipped && !cards[i].isMatched {
                //flip it back over
                print("image before flipped: \(cards[i].displayedImage)")
                
                UIView.transition(with: buttons[i], duration: 0.3, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
                
                var imageAfterFlip = cards[i].flipCard()
                
                print("image after flipped: \(cards[i].displayedImage)")
                
                buttons[i].backgroundColor = self.backColor!
                buttons[i].setBackgroundImage(UIImage(named: cards[i].displayedImage), for: .normal)
                
                //buttons[i].backgroundColor = UIColor(named: "red")
                print("red")
                
            }
            
        }
    }
    
    func disableAllButtons(){
        
        for i in 0..<buttons.count{
            buttons[i].isEnabled = false
            buttons[i].adjustsImageWhenDisabled = false
        }
    }
    
    func enableAllNonMatches(){
        
        for i in 0..<cards.count{
            if !cards[i].isMatched{
                buttons[i].isEnabled = true
            }
        }
        
    }
    
}
