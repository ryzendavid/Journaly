//
//  BackgroundPickerView.swift
//  Journaly
//
//  Created by David Adekunle on 27/03/2025.
//

import SwiftUI

struct BackgroundPickerView: View {
   
    
    @Binding var bacckgroundColor: Color
    @State var backgroundPicker = 0
    var body: some View {
        NavigationStack {
            
           
                ZStack {
                    
                    bacckgroundColor.ignoresSafeArea()
                    
                    ScrollView {
                        VStack{
                            Picker("Background Selector", selection: $backgroundPicker){
                                Text("Colors").tag(0)
                                Text("Images").tag(1)
                                
                            }
                            .pickerStyle(.segmented)
                            .padding()
                            
                            if backgroundPicker == 0 {
                                colorSelectionView(bacckgroundColor: $bacckgroundColor)
                            } else {
                                ImageSelectionView()
                            }
                        }
                        .padding(.top,100)
                    }
                    
                    
                    //.navigationTitle("Journal Background")
                }
                //.ignoresSafeArea()
                
            
            
           
            
        }
        .ignoresSafeArea(.all)
        
    }
}

#Preview {
    BackgroundPickerView(bacckgroundColor: .constant(.blue))
}

struct colorSelectionView: View{
    let colordata : [Color] = [.red,.blue,.green,.yellow,.orange,.purple,.pink,.brown,.black,.hazeBrown,.darkbg, .mint, .white, .bgYellow]
    let rows = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var bacckgroundColor: Color
    var body: some View{
        LazyVGrid(columns: rows, spacing: 35){
            ForEach(colordata, id: \.self){ num in
                Rectangle()
                    .fill(num)
                    .frame(width:100, height: 100)
                    .cornerRadius(20)
                    .onTapGesture {
                        withAnimation{
                            bacckgroundColor = num
                        }
                    }
            }
            
        }
        .padding()
    }
}

struct ImageSelectionView: View{
    var body: some View{
        Text("Image Backgrounds")
    }
}
