//
//  ContentView.swift
//  Memorize
//
//  Created by Oleksandr Pyroh on 13.08.2021.
//

import SwiftUI

struct EmojiTheme: Identifiable {
    let id: Int
    let name: String
    let emojis: [String]
    let systemImageName: String
    
    static var availableThemes: [EmojiTheme] {
        return [
            EmojiTheme(
                id: 0,
                name: "Vehicles",
                emojis: ["🚗", "🚕", "🚙", "🚓", "🚑", "🚚", "🚛", "🚒", "🚌", "🚎", "🏎", "🚜", "🛺"].shuffled(),
                systemImageName: "car"),
            EmojiTheme(
                id: 1,
                name: "Weather",
                emojis: ["🌪", "🌈", "☀️", "🌧", "⛅️", "☁️", "❄️", "💨"].shuffled(),
                systemImageName: "tornado"),
            EmojiTheme(
                id: 2,
                name: "Faces",
                emojis: ["👶", "👧", "🧒", "👦", "👩", "🧑", "👨", "👵", "🧓", "👴"].shuffled(),
                systemImageName: "face.smiling")
        ]
    }
}

struct ContentView: View {
    
    @State var selectedTheme = EmojiTheme.availableThemes[0]
    @State var emojiCount = 8
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(selectedTheme.emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.red)
            }
            Spacer()
            HStack {
                Spacer()
                ForEach(EmojiTheme.availableThemes) { theme in
                    Button {
                        selectedTheme = theme
                    } label: {
                        VStack {
                            Image(systemName: theme.systemImageName)
                                .font(.largeTitle)
                            Spacer()
                            Text(theme.name)
                                .font(.body)
                        }
                    }
                    .aspectRatio(3/2, contentMode: .fit)
                    .padding(.horizontal)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    
    var content: String
    
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack(alignment: .center) {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
