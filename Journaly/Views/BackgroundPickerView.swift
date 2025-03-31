//
//  BackgroundPickerView.swift
//  Journaly
//
//  Created by David Adekunle on 27/03/2025.
//

import SwiftUI

struct BackgroundPickerView: View {
    let colordata : [Color] = [.red,.blue,.green,.yellow,.orange,.purple,.pink,.brown,.black,.hazeBrown,.darkbg, .mint, .white, .bgYellow]
    let rows = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @Binding var bacckgroundColor: Color
    //@Binding var backgroundColorBind : Color
    var body: some View {
            ZStack {
                //Color.
                bacckgroundColor
                LazyVGrid(columns: rows, spacing: 35){
                    ForEach(colordata, id: \.self){ num in
                        Rectangle()
                            .fill(num)
                            .frame(width:100, height: 100)
                            .cornerRadius(20)
                            .onTapGesture {
                                bacckgroundColor = num
                            }
                    }
                    
                }
                .padding()
            
        }
            .ignoresSafeArea(.all)
        
    }
}

#Preview {
    BackgroundPickerView(bacckgroundColor: .constant(.blue))
}

struct colorView: View{
    var body: some View{
        ZStack{
            Rectangle().fill(Color.red)
            
        }
        .frame(width: 200, height: 200)
    }
}
