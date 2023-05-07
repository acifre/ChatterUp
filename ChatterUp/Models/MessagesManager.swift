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
    
    var botText = String()
    
    let db = Firestore.firestore()
    
    init() {
        getMessages()
//        deleteMessages()
    }
    
    func deleteMessages() {
        for message in messages {
            db.collection("messages").document(message.id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
//        db.collection("messages").addSnapshotListener { querySnapshot, error in
//            guard let documents = querySnapshot?.documents else {
//                print("Error fetching documents: \(String(describing: error))")
//                return
//            }
//
//            for document in documents {
//                self.db.collection("messages").document(document.documentID).delete()
//            }
//        }
        

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
    
    func sendMessage(text: String, received: Bool) {
            if !received {
                
                let userRequest = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
                
                db.collection("messages").document(userRequest.id).setData( [
                    "id": userRequest.id,
                    "text": userRequest.text,
                    "received": userRequest.received,
                    "timestamp": Timestamp(date: userRequest.timestamp)
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
            } else {
                
                let botMessage = Message(id: "\(UUID())", text: text, received: true, timestamp: Date())
                
                    db.collection("messages").document(botMessage.id).setData( [
                        "id": botMessage.id,
                        "text": botMessage.text,
                        "received": botMessage.received,
                        "timestamp": Timestamp(date: botMessage.timestamp)
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
            }
    }
}
