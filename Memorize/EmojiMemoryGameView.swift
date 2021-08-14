//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 13.08.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ZStack {
                Text(game.title)
                    .font(.largeTitle)
                    .foregroundColor(game.color)
                HStack {
                    Spacer()
                    Text("\(game.score)")
                        .font(.body)
                        .bold()
                        .padding(.horizontal)
                }
            }
            GeometryReader { geometry in
                ScrollView {
                    let size = widthThatBestFits(cardCount: game.cards.count, in: geometry.size)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: size))]) {
                        ForEach(game.cards) { card in
                            CardView(card: card, colors: game.colorSet)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    game.choose(card)
                                }
                        }
                    }
                    .foregroundColor(game.color)
                }
                .padding(.horizontal)
            }
            Button {
                game.newGame()
            } label: {
                Text("New Game")
                    .font(.title)
            }
            .padding()
        }
    }
    
    private func widthThatBestFits(cardCount: Int, in size: CGSize, inset: CGFloat = 35, spacing: CGFloat = 8) -> CGFloat {
        print("Cards: \(cardCount) | Inset: \(inset) | spacing \(spacing)")
        print("Passed size: \(size.width) | Screen size: \(UIScreen.main.bounds.size.width)")
        let width = size.width
        if width < size.height {
            // Portrait mode
            switch cardCount {
            case 1: return width
            case 2...4: return (width - spacing * 2) / 2 - spacing
            case 5...9: return (width - spacing * 3) / 3 - spacing
            case 10...16: return (width - spacing * 4) / 4 - spacing
            case 17...25: return (width - spacing * 5) / 5 - spacing
            default: return 65
            }
        } else {
            // Landscape mode
            return (width - spacing * 8) / 8 - spacing
        }
    }
    
}

struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    let colors: [Color]?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    if let gradientColors = colors {
                        let gradient = LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
                        shape.fill(gradient)
                    } else {
                        shape.fill()
                    }
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
    
}
