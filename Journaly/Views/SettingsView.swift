//
//  SettingsView.swift
//  Journaly
//
//  Created by David Adekunle on 07/12/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            VStack{
                Image(systemName: "gear")
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
