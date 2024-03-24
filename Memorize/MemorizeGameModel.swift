//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Danny Boie on 3/22/24.
//

import Foundation

struct MemoryGameModel<CardContent> {
    
    private(set) var cards: Array<Card>
    //var score: Int
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        //Add number of pairs of cards x 2 cards
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func choose(_ card: Card) {
    
    }
    

    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
