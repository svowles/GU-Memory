//
//  EasyGameViewController.swift
//  GU Memory
//
//  Created by Sammy on 11/21/18.
//  Copyright © 2018 Sammy. All rights reserved.
//

import UIKit
import GameKit

class EasyGameViewController: UIViewController{//, GKGameCenterControllerDelegate  {
    
    var cards = [Card]()
    
    //names oc the images to be assigned to the cards
    var images = ["Spike.png", "GULogo.png", "CollegeHall.jpg", "Bulldog.jpeg"]
    
    //to capture the previous button clicked
    @IBOutlet var prevButton: UIButton!
    
    @IBOutlet var scoreLabel: UILabel!
    
    var timer: Timer? = nil
    
    var numOfAttempts = 0
    
    var numOfAttemptsLeft = 15
    
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
    
    var buttons = [UIButton]()
    
    
    var btnImg: UIButton!
    
    /**
     action for if a button is clicked
     */
    @IBAction func cardButtonSelected(sender: UIButton){
        
        btnImg = sender
        
        //print(cards[sender.tag].backImage)
        
        backColor = sender.backgroundColor
        
        sender.layer.borderWidth = 0
        
        sender.backgroundColor = UIColor(named: "white")
        sender.backgroundImage(for: .normal)
        
        //if (cards[sender.tag].isFlipped == false) {
            UIView.transition(with: sender, duration: 0.3, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
        //}
        
        //print("image after flipped: \(cards[sender.tag].displayedImage)")
        
        let imageAfterFlip = cards[sender.tag].flipCard()
         
        //print("image after flipped: \(cards[sender.tag].displayedImage)")
         
        //buttons[i].backgroundColor = self.backColor!
        //print("Setting color to \(backColor!)")
        sender.setBackgroundImage(UIImage(named: cards[sender.tag].displayedImage), for: .normal)
        
        
        
        //card7Button.layer.cornerRadius = 10
        //sender.imageView!.
    
        
    //*/
    
        /*
        print("background color: \(sender.backgroundColor!)")
        sender.backgroundColor = UIColor(named: "white")
        sender.backgroundImage(for: .normal)
        //sender.setBackgroundImage(UIImage(named: cards[sender.tag].displayedImage), for: .normal)
        */
        //sender.setImage(UIImage(named: cards[sender.tag].flipCard()), for: .normal)
        sender.isEnabled = false
        sender.adjustsImageWhenDisabled = false
        
        //sender.backgroundImage(for: .normal)
        
        //sender.adjustsImageWhenHighlighted = NO;
        
        
        //print("button selected: \(sender.tag)")
        
        let checkCards = checkForTwoCards()
        //print("CHECK CARDS RESULT:  \(checkCards)")
        
        if checkCards.found{
            
            //add to attempts variable
            if !checkForMatch(cardMatch: checkCards.indexes){
                
                
                
                self.disableAllButtons()
                
                //print("timer starting")
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: {(timer) -> Void in
                    
                    self.buttons[sender.tag].layer.borderWidth = 2
                    self.buttons[self.prevButton.tag].layer.borderWidth = 2
                    
                    let sendImage = self.cards[sender.tag].flipCard()
                    let prevImage = self.cards[self.prevButton.tag].flipCard()
                    
                    //print("prevImage: \(prevImage)")
                    //print("sendImage: \(sendImage)")
                    
                    sender.setBackgroundImage(UIImage(named: sendImage), for: .normal)
                    self.prevButton.setBackgroundImage(UIImage(named: prevImage), for: .normal)
                    
 
                    sender.isEnabled = true
                    self.prevButton.isEnabled = true
                    
                    print("turn 2 cards back over")
                    
                    self.turnOverAllNonMatches()
                    
                    self.enableAllNonMatches()
                    
                    //print("timer ending")
                    
                    
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
        //print("numOfAttempts: \(numOfAttemptsLeft)")
        
        if cards[cardMatch[0]].backImage == cards[cardMatch[1]].backImage {
            cards[cardMatch[0]].isMatched = true
            cards[cardMatch[1]].isMatched = true
            
            //print("MATCH")
            
            
            self.score += numOfAttemptsLeft * 10
            
            scoreLabel.text = "Score: \(score)"
            
            //print("new score: \(score)")
            
            //check to see if game is over
            if isGameOver() {
                print("GAME OVER")
                
                let alertControllerNotValidInput = UIAlertController(title: "GAME OVER", message: "You scored \(score) points.", preferredStyle: .alert)
                
                alertControllerNotValidInput.addAction(UIAlertAction(title: "New Game", style: .default, handler: { (action) in
                        //print("NEW GAME")
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
        //print("CHECKING FOR 2 CARDS")
        var numFlippedCards = 0
        var indexFlipCards = [Int]()
        for i in 0..<cards.count{
            //print("CARD ")
            if cards[i].isFlipped && !cards[i].isMatched{
                numFlippedCards += 1
                indexFlipCards.append(i)
                //print("NUM FLIPPED CARDS: \(numFlippedCards)")
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
        
        buttons = [card0Button, card1Button, card2Button, card3Button, card4Button, card5Button, card6Button, card7Button]
        
        card0Button.layer.cornerRadius = 10
        card1Button.layer.cornerRadius = 10
        card2Button.layer.cornerRadius = 10
        card3Button.layer.cornerRadius = 10
        card4Button.layer.cornerRadius = 10
        card5Button.layer.cornerRadius = 10
        card6Button.layer.cornerRadius = 10
        card7Button.layer.cornerRadius = 10
        
        card0Button.layer.borderWidth = 2
        card0Button.layer.borderColor = UIColor.black.cgColor
        
        card1Button.layer.borderWidth = 2
        card1Button.layer.borderColor = UIColor.black.cgColor
        
        card2Button.layer.borderWidth = 2
        card2Button.layer.borderColor = UIColor.black.cgColor
        
        card3Button.layer.borderWidth = 2
        card3Button.layer.borderColor = UIColor.black.cgColor
        
        card4Button.layer.borderWidth = 2
        card4Button.layer.borderColor = UIColor.black.cgColor
        
        card5Button.layer.borderWidth = 2
        card5Button.layer.borderColor = UIColor.black.cgColor
        
        card6Button.layer.borderWidth = 2
        card6Button.layer.borderColor = UIColor.black.cgColor
        
        card6Button.layer.borderWidth = 2
        card6Button.layer.borderColor = UIColor.black.cgColor
        
        card7Button.layer.borderWidth = 2
        card7Button.layer.borderColor = UIColor.black.cgColor
        
        
        //authenticate user in game center
        authenticateCurrentPlayer()
        
        
        //show rules
    
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
                //print(randNum)
                if !usedRandomNumber.contains(randNum){
                    //print(images[j])
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
        
        print("MAKING A NEW NAME ********************************")
        
        turnOverAllCards()
        
        score = 0
        numOfAttemptsLeft = 15
        setCardImage()
        /*
        var buttonXVal = buttons[0].frame.origin.x
        var buttonYVal = buttons[0].frame.origin.y
        
        var buttonXVal1 = buttons[1].frame.origin.x
        var buttonYVal1 = buttons[1].frame.origin.y
        
        print("Buttons 0: x: \(buttonXVal) y: \(buttonYVal)")
        
        print("Buttons 1: x: \(buttonXVal1) y: \(buttonYVal1)")
        */
        
        for i in 0..<buttons.count{
            
            //buttons[i].superview.frame.origin.x
            
            
            var buttonXVal = buttons[i].frame.maxX//buttons[i].frame.origin.x
            var buttonYVal = buttons[i].frame.maxY// buttons[i].superview!.frame.origin.x
            
            var currWidth = buttons[i].frame.midX
    
            
            var buttonXChange = 0
            
            if buttonXVal == 315{
                buttonXChange = Int( -1 * (currWidth + (-1 * (315 - 123)))) - 20
            }
            else{
                buttonXChange = Int(currWidth + buttonXVal) - 85
            }
            
 
            var buttonYChange =  0
            
            if i < 2 {
                buttonYChange = Int(1.5 * 110.5)
            }
            else if i < 4{
                buttonYChange = Int(0.5 * 110.5)
            }
            else if i < 6{
                buttonYChange = Int(-0.5 * 110.5)
            }
            else {
                buttonYChange = Int(-1.5 * 110.5)
            }
            
            
            
            /*var buttonXVal = buttons[i].superview!.frame.maxX//buttons[i].frame.origin.x
            var buttonYVal = buttons[i].superview!.frame.maxY// buttons[i].superview!.frame.origin.x
            */
 
            print("Buttons \(i): x: \(buttonXVal) y: \(buttonYVal)")
            
            
            UIView.animate(withDuration: 2.0, animations: {
                //let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                let rotateTransform = CGAffineTransform(rotationAngle: .pi)
                let translateTransform = CGAffineTransform(translationX:
                    CGFloat(buttonXChange), y: CGFloat(buttonYChange))
                //let comboTransform = scaleTransform.concatenating(rotateTransform).concatenating(translateTransform)
                
                let comboTransform = rotateTransform.concatenating(translateTransform)
                        
                self.buttons[i].transform = comboTransform}) { (_) in
                    
                    UIView.animate(withDuration: 2.0, animations: {
                        self.buttons[i].transform = CGAffineTransform.identity
                    })
            }
        }
        
        print("NEW GAME!")
        
        for i in 0..<cards.count {
            cards[i].isMatched = false
            //checkForMatch(cardMatch: <#T##[Int]#>)
            
            scoreLabel.text = "Score: \(score)"
        }
        
        for i in 0..<buttons.count{
            
            buttons[i].isEnabled = true
            buttons[i].backgroundImage(for: .normal)
            
            buttons[i].setBackgroundImage(UIImage(named: cards[i].flipCard()), for: .normal)
            
            buttons[i].backgroundColor =
                self.backColor!
            
            //print("Setting color to \(backColor!)")
        }
        
        
    }
    
    func turnOverAllNonMatches(){
        for i in 0..<cards.count {
            
            //if the card has been flipped over but does not have a match
            if cards[i].isFlipped && !cards[i].isMatched {
                
                buttons[i].layer.borderWidth = 2
                
                UIView.transition(with: buttons[i], duration: 0.3, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
                
                //flip it back over
                //print("image before flipped: \(cards[i].displayedImage)")
                
                var imageAfterFlip = cards[i].flipCard()
                
                //print("image after flipped: \(cards[i].displayedImage)")
                
                buttons[i].backgroundColor = self.backColor!
                
                //print("Setting color to \(backColor!)")
                buttons[i].setBackgroundImage(UIImage(named: cards[i].displayedImage), for: .normal)
                
                
                //for testing
                
                //buttons[i].backgroundColor = UIColor(named: "red")
                //print("red")
                
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
    
    func turnOverAllCards(){
        for i in 0..<cards.count {
            
            if cards[i].isFlipped == true {
                print("TURNING OVER")
                
                buttons[i].layer.borderWidth = 2
                
                UIView.transition(with: buttons[i], duration: 0.3, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: nil, completion: nil)
                
               
            }
            
        }
    }
    
}
