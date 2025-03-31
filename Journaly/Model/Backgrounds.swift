//
//  Backgrounds.swift
//  Journaly
//
//  Created by David Adekunle on 26/02/2025.
//

import Foundation
import SwiftUICore


struct ImageBackgrounds{
    
}

struct ColorBackgrounds: Identifiable{
    let id = UUID()
    let name : String
    let color : Color
}

let colorbackgrounds : [ColorBackgrounds] = [
    ColorBackgrounds(name: "Blue", color: Color.blue),
    ColorBackgrounds(name: "Haze Brown", color: Color("HazeBrown")),
    ColorBackgrounds(name: "darkbg", color: Color("darkbg"))
]
