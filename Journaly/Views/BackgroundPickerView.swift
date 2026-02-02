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
                    
                    //background Colour
                    bacckgroundColor.ignoresSafeArea()
                    
                    //background animation
                    AnimatedDottedBackground()
                    
                    //ScrollView {
                        VStack{
                            
//                            Picker("Background Selector", selection: $backgroundPicker){
//                                Text("Colors").tag(0)
//                                Text("Images").tag(1)
//                                
//                            }
//                            .pickerStyle(.segmented)
//                            .padding()
                            
                            if backgroundPicker == 0 {
                                colorSelectionView(bacckgroundColor: $bacckgroundColor)
                            } else {
                                ImageSelectionView()
                            }
                            Spacer()
                        }
                        //.padding(.top,100)
                   // }
                    
                    
                    .navigationTitle("Background")
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
    let colordata : [Color] = [.bgYellow,.happy,.altPurple,.lightblue,.lemonsGreen]
    let rows = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @Binding var bacckgroundColor: Color
    var body: some View{
        
        LazyVGrid(columns: rows, spacing: 35){
            ForEach(colordata, id: \.self){ num in
                VStack{
                    Rectangle()
                        .fill(num)
                        .frame(width:100, height: 100)
                    //.border(num, width: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ), lineWidth: 6)
                            
                        )
                    
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    
                        .onTapGesture {
                            withAnimation{
                                bacckgroundColor = num
                            }
                        }
                    //Text(colordata.)
                        .font(.title2)
                }
            }
            
        }
        .padding()
    }
}

struct ImageSelectionView: View{
    var body: some View{
        Text("Image Backgrounds will be here")
    }
}
