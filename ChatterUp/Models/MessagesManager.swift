//
//  MessagesManager.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/6/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import OpenAISwift

class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId = ""
    
    let db = Firestore.firestore()
    
    init() {
        getMessages()
    }
    
    private
    var client: OpenAISwift?; func setup() {
        client = OpenAISwift(authToken: PrivateKeys.openAIKey)
    }
    
    func sendToChatGPT(text: String, completion: @escaping(String) -> Void) {
        client?.sendCompletion(with: text, maxTokens: 500, completionHandler: {
            result in
            switch result {
            case.success(let model): let output = model.choices?.first?.text ?? ""
                completion(output)
            case.failure(_): break
            }
        })
    }
    
    
    func getMessages() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding document into Message: \(error)")
                    return nil
                }
            }
            
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    
    func sendMessage(text: String, completion: @escaping(String) -> Void) {
        do {
            
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            
            try db.collection("messages").document().setData(from: newMessage)
            
        } catch {
            print("Error adding message to Firestore: \(error)")
        }
    }
}
