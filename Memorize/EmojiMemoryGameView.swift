//
//  ContentView.swift
//  Memorize
//
//  Created by Danny Boie on 3/20/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            Divider()
            buttonStack
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 0)], spacing: 0) {
            ForEach (viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        //TODO: make color associated with theme
        .foregroundColor(viewModel.themeColor)
    }
    
    var buttonStack: some View {
        HStack(spacing: 20) {
            Button(
                action: {
                    viewModel.shuffle()
                },
                label: {
                    VStack {
                        Image(systemName: "shuffle.circle").font(.title)
                        Text("Shuffle")
                    }
                }
            )
            
            
            Text(viewModel.themeName)
                .font(.title3)
            
            Text(String(viewModel.score))
                .font(.title3)
            

            
            Button(
                action: {
                    viewModel.newGame()
                },
                label: {
                    VStack {
                        Image(systemName: "plus.circle").font(.title)
                        Text("New Game")
                    }
                }
            )
        }
        .padding(.horizontal)
    }
}

struct CardView: View {

    let card: MemoryGameModel.Card
    
    init(_ card: MemoryGameModel.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0 )
            base.fill().opacity(card.isFaceUp ? 0 : 1 )
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGameViewModel())
}
