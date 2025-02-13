//
//  JournalView.swift
//  Journaly
//
//  Created by David Adekunle on 25/11/2024.
//

import SwiftUI

struct JournalView: View {
    var  JournView : JournalModel
    @State var contentText : String = ""
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
     // context menu state
    @State var showCMenu = false
    // var menuData : [MenuItem]
    // date format
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    } ()
    
    
    // context menu contents
   
    
    
    //let blur = bl
    var body: some View {
        //expanded view of each journal
        NavigationStack{
            ZStack{
                //if !JournView.Image.isEmpty{
                    Image("")
                        .resizable()
                    //.aspectRatio(contentMode: .fit)
                        .ignoresSafeArea(.all)
                        .blur(radius: 270, opaque: true)
               //e }
                ScrollView{
                    
                    // .opacity(0.9)
                    VStack (alignment: .leading){

                        Text(dateFormatter.string(from: Date()))
                            //.padding(.bottom, 3)
                        Text(JournView.title)
                            .font(.largeTitle)
                            .padding(.bottom,2)
                            .frame(alignment: .leading)
                            
                            
                            
                        
                        Text(JournView.bodyContent)
                        
                        
                        //TextEditor(text: $contentText)
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
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    
                    .padding(10)
                    //.background(.ultraThinMaterial)
                    
                }
            }
           // .navigationTitle("My Journal")
            //.navigationBarTitleDisplayMode(.inline)
           // .navigationBarTitleDisplayMode(.automatic)
            //.preferredColorScheme(JournView.Image.isEmpty ? nil : .dark)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Image(systemName: "waveform")
                        .foregroundStyle(.fill)
                        .font(.title2)
                        .bold()
                        .background(.ultraThinMaterial.opacity(0))
                        .symbolEffect(.bounce.up.byLayer, options: .repeat(.continuous))
                }
                ToolbarItem(placement : .topBarTrailing){
                    Menu{
                        
                        Button{
                            //code to edit
                        } label: {
                            Label("Edit Journal", systemImage: "pencil")
                        }
                        
                        Button{
                            //code to share
                        } label: {
                            Label("Share Journal", systemImage: "square.and.arrow.up.circle")
                        }
                        
                        Button{
                            //code to delete
                           // deleteJournal(deleteJournal)
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
    }
        
    }


#Preview {
    JournalView(JournView: JournalModel(title: "My Journal", Image: "Image", date: Date(), bodyContent: "Reflections, dreams, and daily musings. A safe space for capturing thoughts, tracking growth, and exploring the journey of life. It’s a chronicle of growth, a record of achievements, and a sanctuary for unfiltered self-expression."))
}




