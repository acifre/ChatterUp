//
//  TitleRow.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/6/23.
//

import SwiftUI

struct TitleRow: View {
    @EnvironmentObject var messagesManager: MessagesManager
    @EnvironmentObject var chatHistory: ChatHistory
    @State private var showActionSheet = false
    @State private var showingPopover = false
    @State private var role = ""
    
    var imageURL = URL(string: "https://unsplash.com/photos/ER3BuRKBJ2g")
    var name = "ChatterUp"
    var body: some View {
        HStack(spacing: 20) {
//            AsyncImage(url: imageURL) { image in
//                image.resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 50, height: 50)
//                    .cornerRadius(50)
//            } placeholder: {
//                ProgressView()
//            }
            
            Image("bot2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.white, lineWidth: 1)
                }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
             
            Button {
                showingPopover = true
//                messagesManager.deleteMessages()
                
                
//                DispatchQueue.global(qos: .background).async {
//                    // Perform some background task that updates myState
//                    DispatchQueue.main.async {
//                        self.chatHistory.history = ""
//                    }
//                }
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(50)
            }
        }
        .padding()
        .popover(isPresented: $showingPopover) {

            ChatBotSettings()
                .environmentObject(messagesManager)
                .environmentObject(chatHistory)
        }
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
            .environmentObject(MessagesManager())
            .environmentObject(ChatHistory())
            .background(Color("Marine"))
    }
}

// <a href="https://www.freepik.com/free-vector/chat-bot-free-wallpaper-robot-holds-phone-responds-messages_4015732.htm#page=2&query=chat%20bot&position=14&from_view=search&track=ais">Image by roserodionova</a> on Freepik
