//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 13.08.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    private let emojiGame = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: emojiGame)
        }
    }
    
}
