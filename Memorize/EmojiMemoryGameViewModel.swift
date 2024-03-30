//
//  ContentViewModel.swift
//  Memorize
//
//  Created by Danny Boie on 3/22/24.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    
    @Published private var model = MemoryGameModel(numberOfPairsOfCards: 10) { pairIndex in
        return themes["animalTheme"]?.2[pairIndex] ?? ""
    }
    
    private let themeKeys = Array(themes.keys)
    
    @Published var themeName: String = ""
    @Published var themeColor: Color = Color.orange
    @Published var score: Int = 0
    
    var themeEmojis: [String] = []
    var currentThemeKey: String = ""
    
    init() {
        newGame()
    }
    
    
    //MARK: - Intents
    func newGame() {
        if let randomKey = themeKeys.randomElement() {
            score = 0
            if (randomKey != currentThemeKey) {
                if let randomTheme = themes[randomKey] {
                    let (dataThemeName, dataThemeColor, dataThemeEmojis) = randomTheme
                    
                    currentThemeKey = randomKey
                    themeName = dataThemeName
                    themeEmojis = dataThemeEmojis
                    switch dataThemeColor.lowercased() {
                    case "red":
                        themeColor = Color.red
                    case "blue":
                        themeColor = Color.blue
                    case "yellow":
                        themeColor = Color.yellow
                    default:
                        themeColor = Color.black
                    }
                    
                    //NEW GAME -- NEW MODEL
                    model = MemoryGameModel(
                        numberOfPairsOfCards: 10,
                        cardContentFactory: { pairIndex in
                            return themeEmojis[pairIndex]
                        })
                    model.shuffle()
                    
                } else {
                    print("Failed to retrieve theme for key:", randomKey)
                }
            } else {
                print("No themes found")
            }
        } else {
            newGame()
        }
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    var cards: Array<MemoryGameModel.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGameModel.Card) {
        score = model.choose(card)
    }
}
