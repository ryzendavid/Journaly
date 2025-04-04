//
//  JournalView.swift
//  Journaly
//
//  Created by David Adekunle on 25/11/2024.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    var  JournView : JournalModel
    @StateObject private var audioManager = AudioManager()
    @State var contentText : String = ""
    //@Environment(NavigationContext.self) private var navigationContext
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    let image = Image("Hysterisis")
    @Binding var backgroundColor: Color
    @State var showUpdateView : JournalModel?
    
    
    // context menu state
    @State var showCMenu = false
    
    
    // date format
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    } ()
    
    var body: some View {
        //expanded view of each journal
        NavigationStack{
            ZStack{
                //if !JournView.Image.isEmpty{
//                Image("")
//                    .resizable()
//                //.aspectRatio(contentMode: .fit)
//                    .ignoresSafeArea(.all)
//                    .blur(radius: 270, opaque: true)
                //e }
                //Color.bgYellow.ignoresSafeArea(.all)
                backgroundColor.ignoresSafeArea(.all)
//                (LinearGradient(gradient: Gradient(colors: [Color.lightPurple, Color.actionPink]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea(.all)
                ScrollView{
                    
                    // .opacity(0.9)
                    VStack (alignment: .leading){
                        
                        Text(dateFormatter.string(from: Date()))
                        //.padding(.bottom, 3)
                        Text(JournView.title)
                            .font(.largeTitle)
                            .padding(.bottom,2)
                            .frame(alignment: .leading)
                        
                        
     // text edit does not work with the fill property. I suggest we have the journal body as a text element. then to edit/enter content user has to click the menu button and edit from there
                        
                        Text(JournView.bodyContent)
                        
                        
//                        
//                        TextEditor(text: $contentText)
//                        
//                            
//                            .scrollContentBackground(.hidden)
//                            //.background(.ultraThinMaterial.opacity(0))
//                            .scrollIndicators(.hidden)
//                            .foregroundStyle(.fill)
//                            .background(Color.clear)
//                            
//                        
//                            .onAppear{
//                                contentText = JournView.bodyContent
//                            }
//                            .toolbar{
//                                ToolbarItemGroup(placement: .keyboard){
//                                    Button{
//                                        //
//                                    } label:{
//                                        Image(systemName: "music.note")
//                                    }
//                                    
//                                    Button{
//                                        //
//                                    } label:{
//                                        Image(systemName: "photo.badge.plus")
//                                    }
//                                    
//                                    Button{
//                                        //
//                                    } label:{
//                                        Image(systemName: "photo.badge.plus")
//                                    }
//                                }
//                            }
                            
                        
                        
                    }
                    .bold()
                    .foregroundStyle(.fill)
                    .background(.ultraThinMaterial.opacity(0))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    //.foregroundStyle(colorScheme == .dark ? .white : .black)
                    
                    .padding(10)
                    //.background(.ultraThinMaterial)
                    .onAppear{
                        audioManager.loadSound(named: "ArcSfx")
                    }
                    .sheet(item: $showUpdateView){ journ in
                        updateJournalView(journal: journ)
                    }
                    
                    
                }
            }
            // .navigationTitle("My Journal")
            //.navigationBarTitleDisplayMode(.inline)
            // .navigationBarTitleDisplayMode(.automatic)
            //.preferredColorScheme(JournView.Image.isEmpty ? nil : .dark)
            //.preferredColorScheme(.allCases)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    
                    Button{
                        audioManager.togglePlayback()
                    } label:{
                        if audioManager.isPlaying{
                            Image(systemName: "waveform")
                                .foregroundStyle(.fill)
                                .font(.title2)
                                .bold() 
                                .background(.ultraThinMaterial.opacity(0))
                            
                                .symbolEffect(.bounce.up.byLayer, options: .repeat(.continuous))
                        } else{
                            Image(systemName: "waveform")
                                .foregroundStyle(.fill)
                                .font(.title2)
                                .bold()
                                .background(.ultraThinMaterial.opacity(0))
                        }
                    }
                }
                ToolbarItem(placement : .topBarTrailing){
                    Menu{
                        
                        Button{
                            //code to edit
                            //updateJournalView(journal: JournalModel)
                        } label: {
                            Label("Edit Journal", systemImage: "pencil")
                        }
                        
                        Button{
                            //code to share
//                            ShareLink(item: URL(string: "https://developer.apple.com/documentation/swiftui/sharelink")!)
                            
                           
                           
                        } label: {
                            Label("Share Journal", systemImage: "square.and.arrow.up.circle")
                        }
                        
                        //share journal
                        ShareLink(item: image, preview: SharePreview(JournView.title, image: image)) {
                            Label("Share Journal", systemImage: "square.and.arrow.up")
                        }
                        
                        Button{
                            //code to delete
                            
                            deleteJournal(JournView)
                           
                        
                        } label: {
                            Label("Delete Journal", systemImage: "trash")
                            
                            
                        }
                        //.foregroundStyle(.red)
                        
                        
                        
                    } label: {
                        
                        Image(systemName: "circle.hexagongrid.circle")
                            .foregroundStyle(.fill)
                            .font(.title2)
                            .bold()
                            .background(.ultraThinMaterial.opacity(0))
                            .symbolEffect(.bounce.down.byLayer, options: .nonRepeating)
                        
                        
                    }
                }
            }
            
            
        }
    }
    
    func deleteJournal(_ deleteJournal : JournalModel){
        //let JournDelete = JournalModel
        context.delete(deleteJournal)
        dismiss()
        
        print("Journal has been deleted")
    }
    
    func editJournal(){
        
    }
    
//   private func delJournal(offsets : IndexSet){
//        for index in offsets {
//            context.delete(JournalModel[index])
//        }
//    }
    
}


#Preview {
    JournalView(JournView: JournalModel(title: "My Journal", Image: "Image", date: Date(), bodyContent: "Reflections, dreams, and daily musings. A safe space for capturing thoughts, tracking growth, and exploring the journey of life. It’s a chronicle of growth, a record of achievements, and a sanctuary for unfiltered self-expression."), backgroundColor: .constant(.white))
}

struct updateJournalView: View{
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Bindable var journal : JournalModel
    @State var JournalTitle: String = ""
    @State var JournalContent: String = ""
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
                    TextField("Journal Title", text: $journal.title)
                        .padding()
                        .font(.title)
                    Divider()
                        .frame(height: 10)
                        .padding(.vertical, -20)
                    TextEditor(text: $journal.bodyContent)
                        .foregroundStyle(.fill)
                        .scrollContentBackground(.hidden)
                        .foregroundStyle(.black)
                    //.background(Color.bgYellow)
                        .padding(.top, -20.0)
                    //.ignoresSafeArea()
                    
                    
                }
                
                
                
            }
            .navigationTitle("Update Journal")
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
                       
                    } label: {
                        Text("Save Journal")
                    }
                }
            }
        }
    }
}

//struct CustomTextEditor: UIViewRepresentable {
//    @Binding var text: String
//    var textColor: UIColor
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.backgroundColor = .clear
//        textView.font = UIFont.preferredFont(forTextStyle: .body)
//        textView.textColor = textColor
//        textView.isEditable = true
//        textView.isScrollEnabled = true
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        // Keep the text in sync
//        uiView.text = text
//        // If needed, you can also update the text color here.
//        uiView.textColor = textColor
//    }
//}


// this code below is to call an instance of CustomTextEditor

//CustomTextEditor(text: $contentText, textColor: UIColor.tertiarySystemFill)
//                            .frame(height: 150)
//                            .overlay(RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color.gray, lineWidth: 1))
//                            .onAppear {
//                                contentText = JournView.bodyContent
//                            }
//                    
//                    .padding(10)

