//
//  AnimatedDottedBackground.swift
//  RichText
//
//  Created by David Adekunle on 25/04/2025.
//

import SwiftUI

struct AnimatedDottedBackground: View {
    let dotSize: CGFloat = 3
    let spacing: CGFloat = 20
    let scrollSpeed: CGFloat = 10 // pixels per second
    
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            let offsetY = CGFloat(time) * scrollSpeed

            GeometryReader { geometry in
                Canvas { context, size in
                    let columns = Int(size.width / spacing)
                   // let rows = Int(size.height / spacing)
                    let rows = Int(size.height / spacing) + 2 // add extra rows
                    
                    for row in 0...rows {
                        for column in 0...columns {
                            let x = CGFloat(column) * spacing
                            let y = (CGFloat(row) * spacing + offsetY).truncatingRemainder(dividingBy: spacing * CGFloat(rows + 1))
                            let rect = CGRect(x: x, y: y - spacing, width: dotSize, height: dotSize)
                            context.fill(Path(ellipseIn: rect), with: .color(.gray.opacity(0.5)))
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AnimatedDottedBackground()
}
