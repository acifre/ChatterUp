//
//  Message.swift
//  ChatterUp
//
//  Created by Anthony Cifre on 5/6/23.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date

}
