//
//  JournalView.swift
//  Journaly
//
//  Created by David Adekunle on 25/11/2024.
//

import SwiftUI
import SwiftData
import MapKit

struct JournalView: View {
    var  JournView : JournalModel
    @StateObject private var audioManager = AudioManager()
    @State private var contentText : String = ""
    @State private var blurValues = 0.0
    @State private var isChanging = false
    @State private var toggleBlur = false
    @State private var blurSheet = false
    @State private var showMusicPopover = false
    @State private var showUpdateView = false
    @Binding var backgroundColor: Color
    @Binding var settingBlurToggle : Bool
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    var journals : JournalModel?
    let image = Image("sunsetMobile")
   
    //var mapCooridinates =
    
    
    
    // context menu state
    @State var showCMenu = false
    
//    init(journasl: JournalModel? = nil){
//        self.journals = journals
//        _JournalTitle = State(initialValue: journal?.title ?? "")
//        _JournalContent = State(initialValue: journal?.bodyContent ?? "")
//        _JournalDate = State(initialValue: journal?.date ?? .now)
//        
//    }
    
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
                
                Image("sunsetMobileD")
                    .resizable()
                //.aspectRatio(contentMode: .fit)
                    .ignoresSafeArea(.all)
                    .blur(radius: blurValues, opaque: true)
                //e }
                //Color.bgYellow.ignoresSafeArea(.all)
                //backgroundColor.ignoresSafeArea(.all)
                //                (LinearGradient(gradient: Gradient(colors: [Color.lightPurple, Color.actionPink]), startPoint: .top, endPoint: .bottom)).ignoresSafeArea(.all)
                ScrollView{
                    if !isChanging{
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
                            
//                            Map()
//                                .mapStyle(.standard)
//                                .frame(width: 370, height: 300)
//                                .cornerRadius(15)
//                                .padding(.horizontal,30)
                            
                            
                            
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
//                        .sheet(isPresented: $showUpdateView){
//                            addEditJournalView()
//                        }
                        .sheet(isPresented: $blurSheet){
                            blurView(toggleBlur: $toggleBlur, blurValues: $blurValues, isChanging: $isChanging)
                                .presentationDetents([.height(200)])
                                .presentationDragIndicator(.visible)
                                .presentationCornerRadius(40)
                               
                        }
                        
                        
                        
                        
                        
                    }
                    
                    
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing){
                        
                        Button{
                            audioManager.togglePlayback()
                            showMusicPopover = true
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
                        .popover(isPresented: $showMusicPopover){
                                    MusicView().presentationCompactAdaptation(.popover)
                                .presentationBackground(.fill)
                                .frame(width: 400, height: 400)
                                }
                        .cornerRadius(10)
                    }
                    ToolbarItem(placement : .topBarTrailing){
                        Menu{
                            
                            if settingBlurToggle{
                                Button{
                                    withAnimation{
                                        toggleBlur.toggle()
                                    }
                                    
                                    
                                    //blurSheet = true
                                }label: {
                                    if toggleBlur{
                                        
                                        Label("Background Blur", systemImage: "xmark")
                                    } else{
                                        Label("Background Blur", systemImage: "squareshape.dotted.squareshape")
                                    }
                                }
                            }
                                
                            Button{
                                //code to edit
                                //updateJournalView(journal: JournalModel)
                                showUpdateView = true
                                
                            } label: {
                                Label("Edit Journal", systemImage: "pencil")
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
                //blur view
                    blurView(toggleBlur: $toggleBlur, blurValues: $blurValues, isChanging: $isChanging)
                
            }
            .preferredColorScheme(.dark)
            
            
            
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
    JournalView(JournView: JournalModel(title: "My Journal", Image: "Image", date: Date(), bodyContent: "Reflections, dreams, and daily musings. A safe space for capturing thoughts, tracking growth, and exploring the journey of life. It’s a chronicle of growth, a record of achievements, and a sanctuary for unfiltered self-expression. Reflections, dreams, and daily musings. A safe space for capturing thoughts, tracking growth, and exploring the journey of life. It’s a chronicle of growth, a record of achievements, and a sanctuary for unfiltered self-expression."), backgroundColor: .constant(.red), settingBlurToggle: .constant(true))
}


// no need for this view. add journal has been updated to add/edit based on use case
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


struct blurView: View{
    @Binding var toggleBlur: Bool
    @Binding var blurValues: Double
    @Binding var isChanging: Bool
    //@Binding var toggleBlur: Bool
    var body: some View{
        
        VStack{
            if toggleBlur{
                Spacer()
                //ZStack {
                    Rectangle()
                    .fill(Color.clear)
                        .background(content: {
                            VStack{
                                
                                Spacer()
                                
                                //                        Rectangle()
                                //                            .fill(Color.gray.opacity(0.2))
                                //                            .frame(height: 30)
                                Slider(value: $blurValues, in: 0...500,
                                       onEditingChanged: { editing in
                                    isChanging = editing
                                }
                                )
                                Text("Blur Value: \(String(format:"%.0f",blurValues))")
                                    .font(.system(size: 20, weight: .bold, design: .default))
                            }
                            .padding()
                            .bold()
                            .foregroundStyle(.fill)
                            //.background(.ultraThinMaterial.opacity(0))
                        })
                        .background(.ultraThinMaterial)
                        .frame(height: toggleBlur ? 100 : 20)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundStyle(.fill)
                        
                        
              //
                    
            }
        }
        .padding(.all)
    }
}
