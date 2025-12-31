//
//  MainJournalView.swift
//  Journaly
//
//  Created by David Adekunle on 24/11/2024.
//

import SwiftUI
import SwiftData

struct JournalListView: View {
    @State var showForm: Bool = false
    @Query var Journalss : [JournalModel]
    @Environment(\.modelContext) var context
    @Binding var backgroundColor : Color
    @Binding var settingBlurToggle : Bool
    //@State var search = ""
     var filteredJournals: [JournalModel]{
        guard !searchText.isEmpty else { return Journalss }
        return Journalss.filter{ $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    @Binding var searchText : String
    
    var body: some View {
        NavigationStack {
           
            ZStack {
                // Color.backgroundCo.ignoresSafeArea(.all)
                
                backgroundColor.ignoresSafeArea(.all)
                    //.blur(radius: 30)
//                Image("sunsetMobile")
//                    .resizable()
//                    .ignoresSafeArea()
                ScrollView {
                    
                    // List {
                    VStack(spacing: 22) {
                        
                        
                        
                        ForEach(filteredJournals) { journal in
                            NavigationLink{
                                JournalView(JournView: journal, backgroundColor: $backgroundColor, settingBlurToggle: $settingBlurToggle)
                                
                            } label: {
                                mainListView(JournalListModel: journal)
                            }
                        }
                        .scrollTransition(axis : .vertical) {
                            content, phase in
                            content
                                .scaleEffect(
                                    x: phase.isIdentity ? 1.0 : 0.94,
                                    y: phase.isIdentity ? 1.0 : 0.94
                                )
                        }
                        
                        
                    }
                    .padding()
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing){
                            Button{
                                
                            }label:{
                                Image(systemName: "waveform")
                            }
                        }
                    }

                }
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Journals")
            //.preferredColorScheme(.dark)
            .overlay(
                
                VStack{
                    //Spacer()
                    if Journalss.isEmpty {
                        ContentUnavailableView(
                            label: {
                                Label("No Journals", systemImage: "book")
                                    .font(.largeTitle)
                                    .foregroundStyle(.fill)
                                    .background(.ultraThinMaterial.opacity(0))
                            }, description: {
                                Text("Add Journals to see them here")
                                    .foregroundStyle(.fill)
                                    .background(.ultraThinMaterial.opacity(0))
                            }, actions: {
                                Button{
                                    //
                                    showForm = true
                                } label: {
                                    Text("Add Journal")
                                }
                            }
                        ).offset(y: -60)
                            
                    } else if !searchText.isEmpty{
//                        VStack{
//                            Spacer()
//                            HStack (){
//                                Spacer()
//                                Button {
//                                    hapticFeedback()
//                                    showForm = true
//                                } label: {
//                                    Image(systemName: "plus.circle.fill")
//                                        .font(.system(size: 65))
//                                        .foregroundStyle(.black)
//                                }
//                            }
//                            .padding([.bottom, .trailing], 28.0)
//                        }
                    }
                    else{
                        VStack{
                            Spacer()
                            HStack (){
                                Spacer()
                                Button {
                                    hapticFeedback()
                                    showForm = true
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                      .symbolRenderingMode(.palette)
                                    // this will need to match user's current theme selection
                                      .foregroundStyle(.bgYellow, .black)
                                      .font(.system(size: 65))
                                }
                            }
                            .padding([.bottom, .trailing], 28.0)
                        }
                    }
                    
                    if filteredJournals.isEmpty{
//                        ContentUnavailableView(
//                            label: {
//                                Label("No Results", systemImage: "xmark")
//                                    .font(.largeTitle)
//                                    .foregroundStyle(.fill)
//                                    .background(.ultraThinMaterial.opacity(0))
//                            }
//                        ).offset(y: -60)
                        
                        VStack{
                            Image(systemName: "exclamationmark.magnifyingglass")
                                .font(.system(size: 60))
                            Text("No results for '\(searchText)'")
                                .font(.title2)
                            Text("Check the spelling or try a different search")
                                .font(.caption)
                        }
                        
                    }
                    
                }
            )
        }
//        .searchable(text:$searchText, prompt: "Search Journals")
        .sheet(isPresented: $showForm) {
            addEditJournalView()
        }
            }
    func hapticFeedback(){
        let generator = UIImpactFeedbackGenerator(style:.light)
        generator.impactOccurred(intensity: 1)
    }
}

#Preview {
    JournalListView(backgroundColor: .constant(.red), settingBlurToggle: .constant(true), searchText: .constant("day"))
}

// create list view
struct mainListView : View{
    @Environment(\.modelContext) var context
    var JournalListModel: JournalModel
    @State var showformUpdate: Bool = false
    var journalss: JournalModel?
    var body: some View{
        HStack (alignment: .top){
            
            VStack(alignment: .leading){
                Text(JournalListModel.title)
                    .font(.title)
                    .bold()
                
                Text(JournalListModel.bodyContent)
                    .opacity(0.8)
                    .lineLimit(4)
                //.foregroundStyle(.black)
                
                //.frame(width: 210)
                //Spacer()
            }
            .frame( alignment: .leading)
            .foregroundStyle(.fill)
            .background(.regularMaterial.opacity(0))
            
            .sheet(isPresented: $showformUpdate){
                addEditJournalView(journal: JournalListModel)
            }
        }
        .padding()
        .frame(width: 380, alignment: .topLeading)
        .background(
            ZStack {
                Image("")
                    .resizable()
                    .blur(radius: 150, opaque: true)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
            }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 4)
            
        )
        //.frame(width: 400)
        .contextMenu{
            Button {
                // code to edit journal
                
                showformUpdate = true
                
            } label : {
                Text("Edit Journal")
                    .foregroundStyle(.red)
            }
            
            Button{
                // code to share journal
            } label: {
                Text("Share Journal")
            }
            
            Button (role:.destructive){
                // code to delete journal
                deleteJournal(JournalListModel)
                
                
            } label : {
                Text("Delete Journal")
                    .foregroundStyle(.red)
            }
        }
        
    }
    
    func deleteJournal(_ deleteJournal : JournalModel){
        //let JournDelete = JournalModel
        context.delete(deleteJournal)
    }
}


// for the images, we are using placeholder images for now. we will allow user to select their preffered image from their gallery


//TO DOS
//implement error function when journal entry is empty
//
