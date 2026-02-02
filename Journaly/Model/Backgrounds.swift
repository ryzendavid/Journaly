//
//  Backgrounds.swift
//  Journaly
//
//  Created by David Adekunle on 26/02/2025.
//

import Foundation
import SwiftUI


struct ImageBackgrounds{
    
}

struct GradientItem: Identifiable {
    let id = UUID()
    let name: String
    let style: AnyShapeStyle // This can hold Color OR LinearGradient
}

let gradientArray: [GradientItem] = [
    GradientItem(name: "Midnight", style: AnyShapeStyle(Color.HazeBrown)),
    GradientItem(name: "Sunset Blue", style: AnyShapeStyle(
        LinearGradient(
            stops: [
                .init(color: Color(red: 0.01, green: 0.01, blue: 0.05), location: 0.0),
                .init(color: Color(red: 0.1, green: 0.3, blue: 0.8), location: 0.75),
                .init(color: Color(red: 0.4, green: 0.8, blue: 1.0), location: 0.98)
            ],
            startPoint: UnitPoint(x: 0.8, y: 0.1),
            endPoint: UnitPoint(x: 0.2, y: 0.9)
        )
    ))
]
