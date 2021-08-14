//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 13.08.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let emojiGame = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: emojiGame)
        }
    }
    
}
