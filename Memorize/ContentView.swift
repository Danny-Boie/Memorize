//
//  ContentView.swift
//  Memorize
//
//  Created by Danny Boie on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    //@State is temporary
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("👻")
                    .font(.largeTitle)
            } else {
                base
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
