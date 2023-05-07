//
//  MessageField.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/6/23.
//

import SwiftUI

struct MessageField: View {
    @EnvironmentObject var messagesManager: MessagesManager
    @EnvironmentObject var chatBot: ChatBot
    @EnvironmentObject var chatHistory: ChatHistory
    
    @State private var message = ""
    
    // create an array of string for chat history
    // send chat history to chat gpt but send only user message to firestone
    // create a variable that tracks number of turns
    // after three turns delete the chat history
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Enter your message here"), text: $message)
            
            Button {
                messagesManager.sendMessage(text: message.trimmingCharacters(in: .whitespacesAndNewlines), received: false)
                
                chatHistory.history.append("Me: \(message.trimmingCharacters(in: .whitespacesAndNewlines)) \n")

                chatBot.sendToOpenAI(text: chatHistory.history) { result in
                    print(chatHistory.history)
                    print(result)
                    messagesManager.sendMessage(text: result.trimmingCharacters(in: .whitespacesAndNewlines), received: true)
                    
                    DispatchQueue.global(qos: .background).async {
                        // Perform some background task that updates myState
                        DispatchQueue.main.async {
                            self.chatHistory.history.append("ChatGPT: \(result.trimmingCharacters(in: .whitespacesAndNewlines)) \n")
                        }
                    }
                }
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Marine"))
                    .cornerRadius(50)
            }

        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("Gray"))
        .cornerRadius(50)
        .padding()
        
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
            .environmentObject(MessagesManager())
            .environmentObject(ChatBot())
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}
