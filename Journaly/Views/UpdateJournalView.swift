////
////  UpdateJournalView.swift
////  Journaly
////
////  Created by David Adekunle on 03/04/2025.
////
//
//import SwiftUI
//
//struct UpdateJournalView: View {
//    @Environment(\.dismiss) var dismiss
//    @Environment(\.modelContext) var context
//    //@Bindable var journal : JournalModel
//    @State var JournalTitle: String = ""
//    @State var JournalContent: String = ""
//    var body: some View{
//        NavigationStack{
//            ZStack {
//                //Color.bgYellow.ignoresSafeArea()
//                //                Image("")
//                //                    .resizable()
//                //                    .aspectRatio(contentMode: .fit)
//                //                    .frame(width: 105, height: 100)
//                //                    .clipped()
//                //                    .cornerRadius(11)
//                VStack{
//                    //Color.bgYellow.ignoresSafeArea()
//                    
//                    //Text("Some text")
//                    TextField("Journal Title", text: $JournalTitle)
//                        .padding()
//                        .font(.title)
//                    Divider()
//                        .frame(height: 10)
//                        .padding(.vertical, -20)
//                    TextEditor(text: $JournalContent)
//                        .foregroundStyle(.fill)
//                        .scrollContentBackground(.hidden)
//                        .foregroundStyle(.black)
//                    //.background(Color.bgYellow)
//                        .padding(.top, -20.0)
//                    //.ignoresSafeArea()
//                    
//                    
//                }
//                
//                
//                
//            }
//            .navigationTitle("Journal Entry")
//            .navigationBarTitleDisplayMode(.inline)
//            .presentationBackground(.thickMaterial)
//            .toolbar{
//                ToolbarItem(placement: .topBarLeading){
//                    Button{
//                        dismiss()
//                    }label: {
//                        Text("Cancel")
//                    }
//                }
//                
//                ToolbarItem(placement: .topBarTrailing){
//                    Button{
//                        // code to save journal
//                       
//                    } label: {
//                        Text("Save Journal")
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    UpdateJournalView()
//}
