//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 14.08.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static func createMemoryGame(for theme: EmojiTheme) -> MemoryGame<String> {
        let randomEmojis = theme.emojis.sorted()
        let safePairs = max(1, min(theme.pairsToShow, theme.emojis.count))
        return MemoryGame<String>(numberOfPairsOfCards: safePairs) { index in
            randomEmojis[index]
        }
    }
    
    @Published private var model: MemoryGame<String>
    private var themes: Array<EmojiTheme>
    
    private(set) var title: String
    private(set) var color: Color
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    init() {
        // 16 -> 12 | 13 -> 10 | 10 -> 8 | 8 -> 6 | 6 -> 4 | 3 -> 42
        themes = [
            EmojiTheme(name: "Cars", emojis: ["🚗", "🚕", "🚙", "🚓", "🚑", "🚚", "🚛", "🚒", "🚌", "🚎", "🏎", "🚜", "🛺"], pairsToShow: 10, color: "red"),
            EmojiTheme(name: "Medals", emojis: ["🥇", "🥈", "🥉"], pairsToShow: 42, color: "blue"),
            EmojiTheme(name: "Shoes", emojis: ["👟", "🥾", "👞", "👠", "👡", "👢"], pairsToShow: 4, color: "yellow"),
            EmojiTheme(name: "Hands", emojis: ["👍", "👎", "☝️", "✌️", "🤞", "🤘", "🤟", "✋", "🤚", "🖖", "🤙", "👌", "✊", "👊", "🤛", "🤜"], pairsToShow: 12, color: "green"),
            EmojiTheme(name: "Faces", emojis: ["👶", "👧", "🧒", "👦", "👩", "🧑", "👨", "👵", "🧓", "👴"], pairsToShow: 8, color: "grey"),
            EmojiTheme(name: "Weather", emojis: ["🌪", "🌈", "☀️", "🌧", "⛅️", "☁️", "❄️", "💨"], pairsToShow: 6, color: "purple")
        ]
        let randomTheme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(for: randomTheme)
        title = randomTheme.name
        color = Color(randomTheme.color)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        if let randomTheme = themes.randomElement() {
            model = EmojiMemoryGame.createMemoryGame(for: randomTheme)
            title = randomTheme.name
            color = Color(randomTheme.color)
        }
    }
    
    func addTheme(_ theme: EmojiTheme) {
        themes.append(theme)
    }
    
}

struct EmojiTheme {
    
    let name: String
    let emojis: [String]
    let pairsToShow: Int
    let color: String
    
}
