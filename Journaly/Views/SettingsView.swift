//
//  SettingsView.swift
//  Journaly
//
//  Created by David Adekunle on 07/12/2024.
//

import SwiftUI

struct SettingsView: View {
    let image = Image("Hysterisis")
    
    
    var body: some View {
        NavigationStack {
            VStack{
               
                ShareLink(item: image, preview: SharePreview("Hysterisis", image: image))
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
