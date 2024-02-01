//
//  ContentView.swift
//  Memorize
//
//  Created by Kitso Namane on 07/01/24.
//

import SwiftUI

struct MemorizeView: View {
    let themes = [
        "halloween":["👻", "😈", "👹", "☠️", "🙀", "🧙", "🕸️", "🕷️", "🎃"],
        "transport": ["🚗", "🚀", "🚕", "✈️", "🚁", "🏎️", "🚂", "🛥️"],
        "sports": ["⚽️", "🏉", "🏀", "⚾️", "🎾", "🏐", "🏈", "🥎"]
    ]

    @State var theme: [String] = []
    @State var themeColor: Color =  Color(.green)
    
    
    func themeButton(themeName: String, themeIcon: String, themeColor color: Color) -> some View {
        Button {
                theme = themes[themeName.lowercased()]?.shuffled() ?? []
                themeColor = Color(color)
        } label: {
            VStack {
                Image(systemName: themeIcon)
                    .imageScale(.large)
                Text(themeName)
            }        
        }
        .font(.title3)
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
            ScrollView() {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                    ForEach(0..<theme.count, id: \.self) { index in
                        CardView(content: theme[index])
                            .aspectRatio(3/4, contentMode: .fit)
                    }
                }
                .padding()
            }
            HStack(alignment: VerticalAlignment.bottom, spacing: 24){
                themeButton(themeName: "Halloween", themeIcon: "cloud.bolt.rain.fill", themeColor: .green)
                themeButton(themeName: "Transport", themeIcon: "car.fill", themeColor: .blue)
                themeButton(themeName: "Sports", themeIcon: "basketball.fill", themeColor: .orange)
            }
        }
        .foregroundColor(themeColor)
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    var content: String

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)
            Group {
                base.fill().foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)

            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
            print(content)
            print("tapped : isFaceUP = \(isFaceUp)")
        }
    }
}

#Preview {
    MemorizeView()
}
