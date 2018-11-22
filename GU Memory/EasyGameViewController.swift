//
//  EasyGameViewController.swift
//  GU Memory
//
//  Created by Sammy on 11/21/18.
//  Copyright © 2018 Sammy. All rights reserved.
//

import UIKit

class EasyGameViewController: UIViewController {
    
    @IBOutlet var card0Button: UIButton!
    
    @IBOutlet var card1Button: UIButton!
    
    @IBOutlet var card2Button: UIButton!
    
    @IBOutlet var card3Button: UIButton!
    
    @IBOutlet var card4Button: UIButton!
    
    @IBOutlet var card5Button: UIButton!
    
    @IBOutlet var card6Button: UIButton!
    
    @IBOutlet var card7Button: UIButton!
    
    
    @IBAction func cardButtonSelected(sender: UIButton){
        
        print("button selected: \(sender.tag)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
