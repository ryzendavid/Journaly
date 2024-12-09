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
            ScrollView (.horizontal){
                HStack (spacing: -20){
                    Image("Hysterisis")
                        .resizable()
                        .frame(width: 110, height: 70)
                        .clipShape(Circle())
                    
                    Image("Hysterisis")
                        .resizable()
                        .frame(width: 110, height: 70)
                        .clipShape(Circle())

                    Image("Hysterisis")
                        .resizable()
                        .frame(width: 110, height: 70)
                        .clipShape(Circle())

                    Image("Hysterisis")
                        .resizable()
                        .frame(width: 110, height: 70)
                        .clipShape(Circle())
                    
                    Image("Hysterisis")
                        .resizable()
                        .frame(width: 110, height: 70)
                        .clipShape(Circle())


                }
}
            ZStack {
                Color.bgYellow.ignoresSafeArea(.all)
                
            
                ScrollView {
                    
                   // List {
                        VStack(spacing: 22) {
                            
                            ScrollView (.horizontal){
                                HStack (spacing: -20){
                                    Image("Hysterisis")
                                        .resizable()
                                        .frame(width: 110, height: 70)
                                        .clipShape(Circle())
                                    
                                    Image("Hysterisis")
                                        .resizable()
                                        .frame(width: 110, height: 70)
                                        .clipShape(Circle())

                                    Image("Hysterisis")
                                        .resizable()
                                        .frame(width: 110, height: 70)
                                        .clipShape(Circle())

                                    Image("Hysterisis")
                                        .resizable()
                                        .frame(width: 110, height: 70)
                                        .clipShape(Circle())
                                    
                                    Image("Hysterisis")
                                        .resizable()
                                        .frame(width: 110, height: 70)
                                        .clipShape(Circle())


                                }.frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .offset(x: -280)
            }
                            
                            ForEach(Journalss) { journal in
                                NavigationLink{
                                    JournalView(JournView: journal)
                                    
                                } label: {
                                    mainListView(JournalListModel: journal)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.yellow.opacity(0.1))
                                
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black, lineWidth: 4)
                                //.listRowSpacing(2)
                            )
                            .scrollTransition(axis : .vertical) {
                                content, phase in
                                content
                                    .scaleEffect(
                                        x: phase.isIdentity ? 1.0 : 0.80,
                                        y: phase.isIdentity ? 1.0 : 0.80
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
                        }
                    }
                    .padding([.bottom, .trailing], 28.0)
                }
            }
            .navigationTitle("Journals")
        }
        .sheet(isPresented: $showForm) {
            addJournalView()
        }
    }
    func hapticFeedback(){
        let generator = UIImpactFeedbackGenerator(style:.light)
        generator.impactOccurred(intensity: 0.8)
    }
}

#Preview {
    JournalListView()
}

// create list view
struct mainListView : View{
    var JournalListModel: JournalModel
    var body: some View{
        HStack (alignment : .top){
            
            VStack(alignment: .leading){
                Text(JournalListModel.title)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
                Text(JournalListModel.bodyContent)
                    .opacity(0.5)
                    .lineLimit(2)
                    
                    //.frame(width: 210)
                Spacer()
            }
            .frame(width: 230, alignment: .topLeading)
            
            
            Image("")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
                .frame(width: 105, height: 100)
                .clipped()
                .cornerRadius(11)
            
            //.clipShape(RoundedRectangle(cornerSize: 15))
            
            
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.yellow)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 4)
            
        )
        //.frame(width: 400)
    }
}

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
                Image("")
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
                        .background(Color.bgYellow)
                        .padding(.top, -20.0)
                    //.ignoresSafeArea()
                    
                    
                }
                
                
                
            }
            .navigationTitle("Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
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
                        addnewJourn()
                    } label: {
                        Text("Save Journal")
                    }
                }
            }
        }
    }
    func addnewJourn(){
        let newJournal = JournalModel(title: JournalTitle, Image: "", date: JournalDate, bodyContent: JournalContent)
        context.insert(newJournal)
        dismiss()
    }
    
}


















// for the images, we are using placeholder images for now. we will allow user to select their preffered image from their gallery


//TO DOS
//implement error function when journal entry is empty
//
