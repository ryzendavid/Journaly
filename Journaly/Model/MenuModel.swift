//
//  MenuModel.swift
//  Journaly
//
//  Created by David Adekunle on 06/12/2024.
//

import Foundation

struct MenuItem : Identifiable {
    var id : UUID = UUID()
    
    var itemname : String
    var itemSymbol : String
}

let menuElements : [MenuItem] = [
    MenuItem(itemname: "Share Journal", itemSymbol: "square.and.arrow.up.circle"),
    MenuItem(itemname: "Edit Journal", itemSymbol: "pencil"),
    MenuItem(itemname: "Delete Journal", itemSymbol: "trash")
]
