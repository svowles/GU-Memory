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
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "Level Selection Segue" {
                
                
            }
            
        }
    }

}
