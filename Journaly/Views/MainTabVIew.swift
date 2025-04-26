//
//  MainTabVIew.swift
//  Journaly
//
//  Created by David Adekunle on 27/11/2024.
//

import SwiftUI

struct MainTabVIew: View {
    @State var backgroundColor: Color = .white
    @Binding var settingBlurToggle: Bool
    var body: some View {
        TabView{
            JournalListView(backgroundColor: $backgroundColor, settingBlurToggle: $settingBlurToggle)
                .tabItem{
                    Label("Journal", systemImage: "text.book.closed.fill")
                }
            SettingsView(backgroundColor: $backgroundColor)
                .tabItem{
                Label("Settings", systemImage: "gearshape.fill")
            }
            BackgroundPickerView(bacckgroundColor: $backgroundColor)
                .tabItem{
                    Label("PickerView", systemImage: "circle.hexagongrid.circle")
                }
        }
        //.tint(.darkbg)
    }
}

#Preview {
    MainTabVIew(settingBlurToggle: .constant(true))
}
