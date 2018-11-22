//
//  Card.swift
//  GU Memory
//
//  Created by Sammy on 11/22/18.
//  Copyright © 2018 Sammy. All rights reserved.
//

import Foundation


struct Card {
    var pointValue = 0
    var frontImage: String
    var backImage: String
    var isFlipped = false
    var isMatched = false
    var displayedImage = ""
    
    mutating func flipCard(){
        if self.displayedImage == self.frontImage {
            self.displayedImage = backImage
        }
        else{
            self.displayedImage = frontImage
        }
    }
}
