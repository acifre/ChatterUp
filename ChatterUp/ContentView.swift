//
//  ContentView.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    var messageArray = ["Hello, how are you doing?", "I'm doing great! Thanks for asking. Any plans today?", "No, just going to hang at home!"]
    
    var body: some View {
        VStack {
            TitleRow()
            
            ScrollView {
                ForEach(messageArray, id: \.self) { text in
                    MessageBubble(message: Message(id: "12345", text: text, received: true, timestamp: Date()))
                    
                }
            }
            .padding(.top, 10)
            .background(.white)
        }
        .background(Color("Marine"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
