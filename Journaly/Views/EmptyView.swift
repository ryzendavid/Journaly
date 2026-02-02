////
////  EmptyView.swift
////  Journaly
////
////  Created by David Adekunle on 27/04/2025.
////
//
//import SwiftUI
//
//
//// import JournalingSuggestions
//
//struct JournalEntryView: View {
//    @State private var selectedSuggestion: JournalingSuggestion?
//
//    var body: some View {
//        VStack {
//            // This is the standard picker button
//            JournalingSuggestionsPicker("Choose a Moment") { suggestion in
//                // This closure runs after the user selects a suggestion
//                self.selectedSuggestion = suggestion
//                await handleSelection(suggestion)
//            }
//            .buttonStyle(.borderedProminent)
//            
//            if let suggestion = selectedSuggestion {
//                Text("Selected: \(suggestion.title ?? "New Entry")")
//            }
//        }
//    }
//
//    func handleSelection(_ suggestion: JournalingSuggestion) async {
//        // Here you extract specific data like photos or locations
//        let photos = await suggestion.content(forType: JournalingSuggestion.Photo.self)
//        let workouts = await suggestion.content(forType: JournalingSuggestion.Workout.self)
//        
//        // Use these assets to populate your journal entry editor
//    }
//}
//
//#Preview {
//    JournalEntryView()
//}
