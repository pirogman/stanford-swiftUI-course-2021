//
//  ContentView.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 13.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ZStack {
                Text(viewModel.title)
                    .font(.largeTitle)
                    .foregroundColor(viewModel.color)
                HStack {
                    Spacer()
                    Text("\(viewModel.score)")
                        .font(.body)
                        .bold()
                        .padding(.horizontal)
                }
            }
            GeometryReader { geometry in
                ScrollView {
                    let size = widthThatBestFits(cardCount: viewModel.cards.count, in: geometry.size)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: size))]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card, colors: viewModel.colorSet)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }
                    .foregroundColor(viewModel.color)
                }
                .padding(.horizontal)
            }
            Button {
                viewModel.newGame()
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
    
    let card: MemoryGame<String>.Card
    let colors: [Color]?
    
    var body: some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
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

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
    
}
