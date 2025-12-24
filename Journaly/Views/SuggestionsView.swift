////
////  SuggestionsView.swift
////  Journaly
////
////  Created by David Adekunle on 27/02/2025.
////
//
//import SwiftUI
//
//
//
//
////struct SuggestionsView: View {
////    
////    //@Binding var suggestioncontent : [JournalingSuggestion.Stateofmind]
////    let suggestionsTitle = "Show events"
////    @State var isScaled = false
////    var body: some View {
////       
////        VStack{
////            Text("Journaling Suggestions")
////            Circle()
////                .fill(Color.green)
////                .frame(width: isScaled ? 400 : 0, height: isScaled ? 400 : 0)
////                .animation(.bouncy(duration: 1), value: isScaled)
////            
////            Button{
////                isScaled.toggle()
////            }label: {
////                Text("Scale Circle")
////            }
////        }
////        .frame(minWidth: 300, maxWidth: 800, minHeight: 300, maxHeight: 800)
//////        SuggestionPicker{
//////            
//////        }
////    }
////}
//
//
//
//struct SuggestionsView: View {
//    @State var suggestionPhotos = [JournalingSuggestion.Photo]()
//    @State var suggestionTitle: String? = nil
//    
//    var button titel
//    var body: some View {
//        VStack {
//            Spacer().frame(height: 25)
//            SuggestionsPicker {
//                Text(buttonTitle)
//            } onCompletion: { suggestion in
//                // Parse the suggestion details.
//                suggestionTitle = suggestion.title
//                suggestionPhotos = await suggestion.content(forType: JournalingSuggestion.Photo.self)
//            }
//            // Display the suggestion details.
//            Spacer().frame(height: 25)
//            Text(suggestionTitle ?? "")
//            List {
//                ForEach(suggestionPhotos, id: \.photo) { item in
//                    AsyncImage(url: item.photo) { image in
//                        image.image?
//                            .resizable ()
//                            .aspectRatio(contentMode: .fit)
//                    }
//                    .frame(maxHeight: 200)
//                }
//            }
//        }
//    }
//}
//#Preview {
//    SuggestionsView()
//}
//
//
//
//
//
//
//
//
//
//
//
//struct JournalingSuggestion: Identifiable, Codable {
//    let id: UUID
//    let prompt: String
//    // Add more fields as needed, e.g., category, stateOfMind, etc.
//}
//
//class SuggestionsAPI {
//    static let shared = SuggestionsAPI()
//    func fetchSuggestions() async throws -> [JournalingSuggestion] {
//        let url = URL(string: "https://your.api/suggestions")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return try JSONDecoder().decode([JournalingSuggestion].self, from: data)
//    }
//}
