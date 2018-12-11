//
//  ViewController.swift
//  GU Memory
//
//  Created by Sammy on 11/21/18.
//  Copyright © 2018 Sammy. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    
    @IBOutlet var guMemoryLabel: UILabel!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var achievementsButton: UIButton!

    @IBAction func playButtonSelected(sender: UIButton){
        print("play button selected")
    }
    
    @IBAction func achievementsButtonSelected(sender: UIButton){
        print("achievements button selected")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        playButton.layer.cornerRadius = 10
        
        guMemoryLabel.layer.cornerRadius = 10 
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "Level Selection Segue" {
                
                
            }
            
            if identifier == "Achievements Segue" {
                
                
                
            }
            
        }
        
    }
    
    

}

