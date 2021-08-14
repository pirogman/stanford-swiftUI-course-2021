//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 14.08.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(for theme: EmojiTheme) -> MemoryGame<String> {
        let randomEmojis = theme.emojis.sorted()
        let safePairs = max(1, min(theme.pairs, theme.emojis.count))
        return MemoryGame<String>(numberOfPairsOfCards: safePairs) { index in
            randomEmojis[index]
        }
    }
    
    @Published private var model: MemoryGame<String>
    private var themes: Array<EmojiTheme>
    
    private(set) var title: String
    private(set) var color: Color
    private(set) var colorSet: [Color]?
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    init() {
        themes = [
            // specified pairs
            EmojiTheme(name: "Shoes", emojis: ["👟", "🥾", "👞", "👠", "👡", "👢"], mainColor: "yellow", pairsToShow: 4),
            EmojiTheme(name: "Hands", emojis: ["👍", "👎", "☝️", "✌️", "🤞", "🤘", "🤟", "✋", "🤚", "🖖", "🤙", "👌", "✊", "👊", "🤛", "🤜"], mainColor: "green", pairsToShow: 12),
            // gradient theme
            EmojiTheme(name: "Cars", emojis: ["🚗", "🚕", "🚙", "🚓", "🚑", "🚚", "🚛", "🚒", "🚌", "🚎", "🏎", "🚜", "🛺"], mainColor: "red", gradientColors: ["orange", "red", "orange"], pairsToShow: 10),
            // more than possible
            EmojiTheme(name: "Medals", emojis: ["🥇", "🥈", "🥉"], mainColor: "blue", pairsToShow: 42),
            // random each time
            EmojiTheme(name: "Faces", emojis: ["👶", "👧", "🧒", "👦", "👩", "🧑", "👨", "👵", "🧓", "👴"], mainColor: "grey", randomPairs: true),
            // defaults to all
            EmojiTheme(name: "Weather", emojis: ["🌪", "🌈", "☀️", "🌧", "⛅️", "☁️", "❄️", "💨"], mainColor: "purple")
        ]
        
        let randomTheme = themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(for: randomTheme)
        title = randomTheme.name
        color = Color(randomTheme.mainColor)
        colorSet = randomTheme.gradientColors?.map { Color($0) }
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func newGame() {
        if let randomTheme = themes.randomElement() {
            model = EmojiMemoryGame.createMemoryGame(for: randomTheme)
            title = randomTheme.name
            color = Color(randomTheme.mainColor)
            colorSet = randomTheme.gradientColors?.map { Color($0) }
        }
    }
    
    func addTheme(_ theme: EmojiTheme) {
        themes.append(theme)
    }
    
    struct EmojiTheme {
        
        let name: String
        let emojis: [String]
        let mainColor: String
        let gradientColors: [String]?
        
        private let pairsToShow: Int
        private let randomPairs: Bool
        
        var pairs: Int {
            randomPairs
                ? Int.random(in: 2...emojis.count)
                : pairsToShow
        }
        
        init(name: String, emojis: [String], mainColor: String, gradientColors: [String] = [], pairsToShow: Int? = nil, randomPairs: Bool = false) {
            self.name = name
            self.emojis = emojis
            self.mainColor = mainColor
            self.gradientColors = gradientColors.isEmpty ? nil : gradientColors
            self.pairsToShow = pairsToShow ?? emojis.count
            self.randomPairs = randomPairs
        }
        
    }
    
}
