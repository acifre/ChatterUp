//
//  ChatBotSettings.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/7/23.
//

import SwiftUI

struct ChatBotSettings: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var messagesManager: MessagesManager
    @EnvironmentObject var chatHistory: ChatHistory
    
    @State private var role = ""
    @State private var tokens = 500
    @State private var turns = 3
    @State private var isDarkMode = false
    
    var body: some View {

        
        VStack {
            Spacer()
            Text("Settings")
                .font(.headline)
                .padding(5)
            
            Form {
                Section("ChatBot Settings") {
                    LabeledContent {
                        Button("Change Role") {
                            
                        }
                        .padding(2)
                        .frame(maxWidth: 125, maxHeight: 30).background(Color("Marine"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    } label: {
                        Text("ChatBot Role")
                    }
                    .padding(.horizontal, 2)
                    
                    LabeledContent {
                        TextField("Maximum Tokens", value: $tokens, format: .number)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("Maximum Tokens")
                        
                    }
                    .padding(.horizontal, 2)
                    
                    Picker("Turns", selection: $turns) {
                        ForEach(0..<6) {
                            Text("\($0)")
                        }
                    }
                    .padding(.horizontal, 1)
                    
                    Button {
                        messagesManager.deleteMessages()
                        chatHistory.history = ChatHistory.firstRole
                        dismiss()
                        
                    } label: {
                        Text("Delete Chat History")
                            .foregroundColor(.red)
                    }
//                    .frame(maxWidth: .infinity)
                    
                    Button {
                        chatHistory.role = role
                        chatHistory.tokens = tokens
                        chatHistory.turns = turns
                        dismiss()
                        
                    } label: {
                        Text("Save Settings")
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity)


                }
                .listRowBackground(Color("Gray"))
//                .listRowSeparatorTint(Color("Marine"))
                
                Section("App Settings") {
                    Toggle("Appearance", isOn: $isDarkMode)
                        .padding(.horizontal, 2)
                }
                .listRowBackground(Color("Gray"))
                
                Section {
                    Text("""

        **Role**: You can give the ChatBot a certain role (i.e., a proof editor).

        **Tokens**: Set the maximum number of tokens used for each request.

        **Turns**: You can specify how many conversation turns will be sent each request.
        """)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .frame(maxWidth: .infinity)

                    .background(Color("Gray"))
                    .border(Color("Marine"), width: 10)
                    .cornerRadius(10)
                    
                }

                

            }
            .scrollContentBackground(.hidden)
            .tint(Color("Marine"))
            

        }
    }
}

struct ChatBotSettings_Previews: PreviewProvider {
    static var previews: some View {
        ChatBotSettings()
    }
}
