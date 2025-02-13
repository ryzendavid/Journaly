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
                Color.bgYellow.ignoresSafeArea(.all)
                
            
                ScrollView {
                    
                   // List {
                        VStack(spacing: 22) {
                            
                            
                            
                            ForEach(Journalss) { journal in
                                NavigationLink{
                                    JournalView(JournView: journal)
                                    
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
                        
                        
                        //                        .overlay(
                        //
                        //                            VStack{
                        //                                //Spacer()
                        //                                if Journalss.isEmpty {
                        //                                    ContentUnavailableView(
                        //                                        label: {
                        //                                            Label("No Journals", image: "rectangle.portrait.slash.fill")
                        //                                        }, description: {
                        //                                            Text("Add Journals to see them here")
                        //                                        }, actions: {
                        //                                            Button{
                        //                                                //
                        //                                            } label: {
                        //                                                Text("Add Journal")
                        //                                            }
                        //                                        }
                        //                                    )
                        //                                } else{
                        //                                    HStack{
                        //                                        Spacer()
                        //                                        Button {
                        //                                            showForm.toggle()
                        //                                            hapticFeedbackError()
                        //
                        //                                        } label: {
                        //                                            Image(systemName: "plus.circle.fill")
                        //                                                .font(.largeTitle)
                        //                                        }
                        //                                    }
                        //                                    .padding()
                        //                                }
                        //
                        //                            }
                        //                        )
                    }
                .scrollIndicators(.hidden)
                                    
                    
                    
                //}
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
            .navigationTitle("Journals")
            //.preferredColorScheme(.dark)
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
    JournalListView()
}

// create list view
struct mainListView : View{
    var JournalListModel: JournalModel
    let MenuItems = ContextMenu {
        Button{
            // code to share journal
        } label: {
            Text("Share Journal")
        }
        
        Button {
            // code to delete journal
        } label : {
            Text("Delete Journal")
                .foregroundStyle(.red)
        }
    }
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
        .contextMenu(MenuItems)
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
    var body: some View{
        NavigationStack{
            ZStack {
                //Color.bgYellow.ignoresSafeArea()
                Image("Hysterisis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 105, height: 100)
                    .clipped()
                    .cornerRadius(11)
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
            .navigationTitle("Journal Entry")
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
        let newJournal = JournalModel(title: JournalTitle, Image: "", date: JournalDate, bodyContent: JournalContent)
        context.insert(newJournal)
        dismiss()
    }
    
    //deleteJournal
    func deleteJournal(_ deleteJournal : JournalModel){
        //let JournDelete = JournalModel
        context.delete(deleteJournal)
    }
    
}


















// for the images, we are using placeholder images for now. we will allow user to select their preffered image from their gallery


//TO DOS
//implement error function when journal entry is empty
//
