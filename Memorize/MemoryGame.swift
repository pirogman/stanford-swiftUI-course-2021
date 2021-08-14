//
//  MemoryGame.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 14.08.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
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
                    score += 2
                }
                onlyFaceUpCardIndex = nil
            } else {
                for index in cards.indices {
                    if cards[index].isFaceUp {
                        if !cards[index].isMatched && cards[index].timesSeen > 0 {
                            score -= 1
                        }
                        cards[index].timesSeen += 1
                    }
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
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var timesSeen: Int = 0
        var content: CardContent
        var id: Int
    }
    
}
