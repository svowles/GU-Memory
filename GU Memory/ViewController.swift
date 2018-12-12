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
    
    @IBOutlet var spikeImage: UIImageView!
    
    @IBAction func achievementsButtonSelected(sender: UIButton){
        print("achievements button selected")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        playButton.layer.cornerRadius = 10
        
        guMemoryLabel.layer.cornerRadius = 10
    
        
        UIView.animate(withDuration: 1.0, animations: {
            let scaleTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            self.playButton.transform = scaleTransform})
            { (_) in
                
                UIView.animate(withDuration: 1.0, animations: {
                    self.playButton.transform = CGAffineTransform.identity
                })
            }
        
        
        UIView.animate(withDuration: 2.0, animations:{
            let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            let rotateTransform = CGAffineTransform(rotationAngle: .pi)
            let translateTransform = CGAffineTransform(translationX:
                0, y: 0)
            
            
            let comboTransform = rotateTransform.concatenating(translateTransform)
                            
            self.spikeImage.transform = comboTransform}) { (_) in
                
            UIView.animate(withDuration: 2.0, animations: {
                self.spikeImage.transform = CGAffineTransform.identity
            })
                
        }
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

