//
//  ContentView.swift
//  Memorize
//
//  Created by Danny Boie on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var cardCount: Int = 15
    @State var theme: String = "foodTheme"

    var body: some View {
        VStack {
            header
            ScrollView {
                cards
            }
            buttonStack
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            let shuffledThemes = (themes[theme] ?? []).shuffled()
            ForEach (0..<shuffledThemes.count, id: \.self) { index in
                CardView(content: shuffledThemes[index])
                    .aspectRatio(4/5, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var header: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }

    var buttonStack: some View {
        HStack(spacing: 20) {
            Button(
                action: {
                    theme = "foodTheme"
                },
                label: {
                    VStack {
                        Image(systemName: "carrot.fill").font(.title)
                        Text("Food")
                    }
                }
            )
            Button(
                action: {
                    theme = "animalTheme"
                },
                label: {
                    VStack {
                        Image(systemName: "dog.fill").font(.title)
                        Text("Animals")
                    }
                }
            )
            Button(
                action: {
                    theme = "vehicleTheme"
                },
                label: {
                    VStack {
                        Image(systemName: "car.fill").font(.title)
                        Text("Vehicles")
                    }
                }
            )
        }
        .padding(.horizontal)
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0 )
            base.fill().opacity(isFaceUp ? 0 : 1 )
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
