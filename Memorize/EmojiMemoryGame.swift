//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 14.08.2021.
//

import SwiftUI

class EmojiMemoryGame {
    
    static let emojis = ["🚗", "🚕", "🚙", "🚓", "🚑", "🚚", "🚛", "🚒", "🚌", "🚎", "🏎", "🚜", "🛺"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { index in
            emojis[index]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
}
