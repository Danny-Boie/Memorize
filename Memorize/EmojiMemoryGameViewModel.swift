//
//  ContentViewModel.swift
//  Memorize
//
//  Created by Danny Boie on 3/22/24.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    @Published private var model = MemoryGameModel(numberOfPairsOfCards: 10) { pairIndex in
        return themes["animalTheme"]?[pairIndex] ?? ""
    }
    
    //MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    var cards: Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
}
