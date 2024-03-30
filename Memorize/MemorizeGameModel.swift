//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Danny Boie on 3/22/24.
//

import Foundation

struct MemoryGameModel{
    
    private(set) var cards: Array<Card>
    var indexOfOneChosenCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    private(set) var gameTheme: (String, String, [String]) = ("","", [])
    
    private(set) var score: Int = 0
    
    
    //MARK: - INIT
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> String) {
        cards = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    //MARK: - FUNCTIONS
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) -> Int {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
              
                if let potentialMatchIndex = indexOfOneChosenCard {
                   
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score = score + 2
                    } else {
                        if (cards[chosenIndex].hasBeenSeen || cards[potentialMatchIndex].hasBeenSeen) {
                            score = score - 1
                        } else {
                            cards[chosenIndex].hasBeenSeen = true
                            cards[potentialMatchIndex].hasBeenSeen = true
                        }
                    }
                    
                } else {
                    indexOfOneChosenCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
        return score
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    

    //MARK: - CARD
    struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
        let content: String
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }

    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
