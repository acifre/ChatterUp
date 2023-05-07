//
//  ContentView.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var messagesManager = MessagesManager()
    @ObservedObject var chatBot = ChatBot()
    @ObservedObject var chatHistory = ChatHistory()
    
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                    .environmentObject(messagesManager)
                    .environmentObject(chatHistory)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        withAnimation {
                            ForEach(messagesManager.messages, id: \.id) { message in
                                MessageBubble(message: message)
                                    .textSelection(.enabled)
                                
                            }
                        }

                    }
                    .padding(.top, 10)
                    .background(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .onChange(of: messagesManager.lastMessageId) { id in
                    withAnimation {
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
                }
            }
            .background(Color("Marine"))
            
            MessageField()
                .environmentObject(messagesManager)
                .environmentObject(chatBot)
                .environmentObject(chatHistory)
        }
        .onAppear {
            chatBot.setup()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
