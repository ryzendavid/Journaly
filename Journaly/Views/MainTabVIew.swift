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
    @State var searchJournals = ""
    @FocusState var searchFocus : Bool
    
    
    var body: some View {
            TabView {
                Tab("Journal", systemImage: "text.book.closed.fill") {
                    JournalListView(backgroundColor: $backgroundColor, settingBlurToggle: $settingBlurToggle, searchText: $searchJournals)
                }
                Tab("Settings", systemImage: "gearshape.fill"){
                    SettingsView(backgroundColor: $backgroundColor)
                }
                Tab("Search", systemImage: "magnifyingglass", role: .search){
                    NavigationStack{
                        JournalListView(backgroundColor: $backgroundColor, settingBlurToggle: $settingBlurToggle, searchText: $searchJournals)
                        
                        
                        
                    }
                    .searchable(text:$searchJournals, prompt: "Search Journals")
                    
                    //binds focus
                    .focused($searchFocus)
                    .onChange(of: searchFocus){
                        searchJournals = ""
                        
                    }
                }
        }
        
        
    }
}

#Preview {
    MainTabVIew(settingBlurToggle: .constant(true))
}
