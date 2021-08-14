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
                    .bold()
                HStack {
                    Spacer()
                    Text("\(viewModel.score)")
                        .font(.body)
                        .padding(.horizontal)
                }
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
                .foregroundColor(viewModel.color)
            }
            .padding(.horizontal)
            Button {
                viewModel.newGame()
            } label: {
                Text("New Game")
                    .font(.title)
            }
            .padding()
        }
    }
    
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
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
                shape.fill()
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
