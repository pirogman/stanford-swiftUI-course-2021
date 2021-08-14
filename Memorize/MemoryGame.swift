//
//  MemoryGame.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 14.08.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private var onlyFaceUpCardIndex: Int?
    
    mutating func choose(_ card: Card) {
        if let selectedIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[selectedIndex].isFaceUp,
           !cards[selectedIndex].isMatched
        {
            if let potentialMatchIndex = onlyFaceUpCardIndex {
                if cards[potentialMatchIndex].content == cards[selectedIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[selectedIndex].isMatched = true
                }
                onlyFaceUpCardIndex = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                onlyFaceUpCardIndex = selectedIndex
            }
            cards[selectedIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        for i in 0..<numberOfPairsOfCards {
            let content = createCardContent(i)
            cards.append(Card(content: content, id: i * 2))
            cards.append(Card(content: content, id: i * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
}
