//
//  CardModel.swift
//  MemoryCards
//
//  Created by Alaattin Bulut Öztemur on 21.02.2021.
//

import Foundation

class CardModel {
    
    func getCards(numOfCards: Int) -> [Card] {
        
        //  Declare an empty array
        var generatedCards = [Card]()
        var used = [Bool?](repeating: nil, count: 13)
        
        var counter = 0
        // Randomly generate 8 pairs of cards
        while counter < numOfCards {
            
            // Generate a random number
            let randomNumber = Int.random(in: 1...13)
            
            /*if(used[randomNumber-1] == true){
                // If the same number generated in advance
                continue
            } */
            
            used[randomNumber-1] = true
            counter += 1
            
            // Create two new card objects
            let cardOne = Card()
            let cardTwo = Card()
            
            // Set their images
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            // Add them to the array
            generatedCards.append(contentsOf: [cardOne, cardTwo])
        }
        
        // Randomize the cards within the array
        generatedCards.shuffle()
        
        // Return the array
        return generatedCards
    }
    
    
}
