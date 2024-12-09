//
//  MainTabVIew.swift
//  Journaly
//
//  Created by David Adekunle on 27/11/2024.
//

import SwiftUI

struct MainTabVIew: View {
    var body: some View {
        TabView{
            JournalListView()
                .tabItem{
                    Label("Journal", systemImage: "text.book.closed.fill")
                }
            
            
        }
    }
}

#Preview {
    MainTabVIew()
}
