//
//  LevelSelectionViewController.swift
//  GU Memory
//
//  Created by Sammy on 11/21/18.
//  Copyright © 2018 Sammy. All rights reserved.
//

import UIKit

class LevelSelectionViewController: UIViewController {
    
    @IBOutlet var levelSelectionLabel: UILabel!
    
    @IBOutlet var easyButton: UIButton!
    
    @IBOutlet var mediumButton: UIButton!
    
    @IBOutlet var hardButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        easyButton.layer.cornerRadius = 10
        mediumButton.layer.cornerRadius = 10
        hardButton.layer.cornerRadius = 10
        
        let alertControllerNotValidInput = UIAlertController(title: "Game Rules", message: "To begin a game, select the level you would like to play. The easy level is played with 8 cards, the medium level with 16 cards and the hard level with 32 cards.  Click on any 2 cards. If the two cards match, you will be awarded points which are added to your score and the cards will stay flipped over. The points added to your score gets lower as it you have non-matches. Otherwise, the cards are flipped back over and you try again. The game is over when all the cards have been matched. To play again, select the \"Play Again\" button. ", preferredStyle: .alert)
        
        alertControllerNotValidInput.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
        
        present(alertControllerNotValidInput, animated: true, completion: nil)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "Level Selection Segue" {
                
                
            }
            
        }
    }

}
