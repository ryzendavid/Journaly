//
//  addEditJournal.swift
//  Journaly
//
//  Created by David Adekunle on 04/04/2025.
//

import SwiftUI

struct addEditJournalView: View {
    //var JournalFormModel : JournalModel
    @Environment(\.dismiss) var dismiss
    @State var JournalTitle: String = ""
    @State var JournalContent: String = ""
    @State var JournalDate: Date = .now
    @State var JournalImage: String = ""
    @Environment(\.modelContext) var context
    
    
    // initialiser. takes optional journalModel for each journal when adding/editing. if data is already there, use it else, create new empty journal
    init(journal: JournalModel? = nil){
        self.journal = journal
        _JournalTitle = State(initialValue: journal?.title ?? "")
        _JournalContent = State(initialValue: journal?.bodyContent ?? "")
        _JournalDate = State(initialValue: journal?.date ?? .now)
        
    }
    
    // optional JournalModel for if user already data for the current journal
    var journal: JournalModel?
    var body: some View{
        NavigationStack{
            ZStack {
                //Color.bgYellow.ignoresSafeArea()
                //                Image("")
                //                    .resizable()
                //                    .aspectRatio(contentMode: .fit)
                //                    .frame(width: 105, height: 100)
                //                    .clipped()
                //                    .cornerRadius(11)
                VStack{
                    //Color.bgYellow.ignoresSafeArea()
                    
                    //Text("Some text")
                    TextField("Journal Title", text: $JournalTitle)
                        .padding()
                        .font(.title)
                    Divider()
                        .frame(height: 10)
                        .padding(.vertical, -20)
                    TextEditor(text: $JournalContent)
                        //.foregroundStyle(.fill)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.black)
                    //.background(Color.bgYellow)
                        .padding(.top, -20.0)
                    //.ignoresSafeArea()
                    
                    
                }
                
                
                
            }
            //runs when add/edit screen is clicked on and appears. then checks if journal is nil or not. if it isn't, it fills in the data
            .onAppear {
                if let journal = journal {
                    JournalTitle = journal.title
                    JournalContent = journal.bodyContent
                    JournalDate = journal.date
                }
            }
            .navigationTitle(journal == nil ? "New Journal" : "Edit Journal")
            .navigationBarTitleDisplayMode(.inline)
            .presentationBackground(.thickMaterial)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    }label: {
                        Text("Cancel")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        // code to save journal
                        SaveJournal()
                    } label: {
                        Text("Save Journal")
                    }
                }
            }
        }
    }
    //save journal
    func SaveJournal(){
        //checks if journal is nil and creates and new journal if it is. if it not, it updates the selected existing journal and saves it
        if let journal = journal{
            journal.title = JournalTitle
            journal.bodyContent = JournalContent
            journal.date = JournalDate
            
        } else{
            let newJournal = JournalModel(title: JournalTitle, Image: "", date: JournalDate, bodyContent: JournalContent)
            context.insert(newJournal)
            
        }
        dismiss()
    }
}

#Preview {
    addEditJournalView()
}
