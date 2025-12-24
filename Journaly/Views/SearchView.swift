//
//  SearchView.swift
//  Journaly
//
//  Created by David Adekunle on 24/12/2025.
//

import SwiftUI

struct SearchView: View {
    @State var backgroundColor: Color = .white
    @Binding var settingBlurToggle: Bool
    @State var searchJourn: String = ""
    var body: some View {
        Image(systemName: "plus.circle.fill")
          .symbolRenderingMode(.hierarchical)   // or .palette
          .foregroundStyle(.black)
          .font(.system(size: 65))
        
        Image(systemName: "plus.circle.fill")
          .symbolRenderingMode(.palette)
          .foregroundStyle(.lemonsGreen, .black)
          .font(.system(size: 65))


    }
}

#Preview {
    SearchView(settingBlurToggle: .constant(true))
}
