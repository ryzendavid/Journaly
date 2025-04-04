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
    
    var body: some View {
        NavigationStack {
            //            ScrollView (.horizontal){
            //
            //                //wekekly journs
            //
            //                HStack (spacing: -20){
            //                    Image("Hysterisis")
            //                        .resizable()
            //                        .frame(width: 110, height: 70)
            //
            //                        .clipShape(Circle())
            ////                        .overlay(
            ////                            RoundedRectangle(cornerSize: 14)
            ////                        )
            //                    Image("Hysterisis")
            //                        .resizable()
            //                        .frame(width: 110, height: 70)
            //                        .clipShape(Circle())
            //
            //                    Image("Hysterisis")
            //                        .resizable()
            //                        .frame(width: 110, height: 70)
            //                        .clipShape(Circle())
            //
            //                    Image("Hysterisis")
            //                        .resizable()
            //                        .frame(width: 110, height: 70)
            //                        .clipShape(Circle())
            //
            //                    Image("Hysterisis")
            //                        .resizable()
            //                        .frame(width: 110, height: 70)
            //                        .clipShape(Circle())
            //
            //
            //                }
            //}
            //            .scrollIndicators(.hidden)
            ZStack {
               // Color.backgroundCo.ignoresSafeArea(.all)
                
                backgroundColor.ignoresSafeArea(.all)
                ScrollView {
                    
                    // List {
                    VStack(spacing: 22) {
                        
                        
                        
                        ForEach(Journalss) { journal in
                            NavigationLink{
                                JournalView(JournView: journal, backgroundColor: $backgroundColor)
                                
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
                    
                    
                   
                }
                .scrollIndicators(.hidden)
                
                
                
                //}

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
                            }, description: {
                                Text("Add Journals to see them here")
                            }, actions: {
                                Button{
                                    //
                                    showForm = true
                                } label: {
                                    Text("Add Journal")
                                }
                            }
                        ).offset(y: -60)
                    } else{
                                        VStack{
                                            Spacer()
                                            HStack (){
                                                Spacer()
                                                Button {
                                                    hapticFeedback()
                                                    showForm = true
                                                } label: {
                                                    Image(systemName: "plus.circle.fill")
                                                        .font(.system(size: 65))
                                                        .foregroundStyle(.black)
                                                }
                                            }
                                            .padding([.bottom, .trailing], 28.0)
                                        }
                    }
                    
                }
            )
        }
        .sheet(isPresented: $showForm) {
            addJournalView()
        }
    }
    func hapticFeedback(){
        let generator = UIImpactFeedbackGenerator(style:.light)
        generator.impactOccurred(intensity: 1)
    }
}

#Preview {
    JournalListView(backgroundColor: .constant(.red))
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
                addJournalView(journal: JournalListModel)
            }
            
            
            //            Image("Hysterisis")
            //                .resizable()
            //                .aspectRatio(contentMode: .fill)
            //
            //                .frame(width: 105, height: 100)
            //                .clipped()
            //                .cornerRadius(11)
            
            //.clipShape(RoundedRectangle(cornerSize: 15))
            
            
            
        }
        .padding()
        .frame(width: 380, alignment: .topLeading)
        .background(
            ZStack {
                Image("")
                    .resizable()
                
                
                // Color.white
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
            
            Button {
                // code to delete journal
                //deleteJournal(JournalListModel)
                
                
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

// create new journal
struct addJournalView: View{
    //var JournalFormModel : JournalModel
    @Environment(\.dismiss) var dismiss
    @State var JournalTitle: String = ""
    @State var JournalContent: String = ""
    @State var JournalDate: Date = .now
    @State var JournalImage: String = ""
    @Environment(\.modelContext) var context
    
    init(journal: JournalModel? = nil){
        self.journal = journal
        _JournalTitle = State(initialValue: journal?.title ?? "")
        _JournalContent = State(initialValue: journal?.bodyContent ?? "")
        _JournalDate = State(initialValue: journal?.date ?? .now)
        
    }
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
                        .foregroundStyle(.fill)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.black)
                    //.background(Color.bgYellow)
                        .padding(.top, -20.0)
                    //.ignoresSafeArea()
                    
                    
                }
                
                
                
            }
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



struct JournalFormModel {
    var title: String = ""
    var bodyContent: String = ""
    var date: Date = Date()
}












// for the images, we are using placeholder images for now. we will allow user to select their preffered image from their gallery


//TO DOS
//implement error function when journal entry is empty
//
