//
//  ChatHistory.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/7/23.
//

import Foundation
import SwiftUI

class ChatHistory: ObservableObject {
    @Published var history = ""
    @Published var role = "" 
    @Published var tokens = 500
    @Published var turns = 3
    
    static var firstRole = "I want you to act as yourself ChatGPT. I will provide you commands prepended with 'Me:'. Sometimes I will also provide your previous responses prepened with 'ChatGPT'. Use all the information I've provided to formulate your answers. When you do answer do not prepend your response with ChatGPT. Just give me the text of your response."
}
