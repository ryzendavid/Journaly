//
//  MusicView.swift
//  Journaly
//
//  Created by David Adekunle on 26/04/2025.
//

import SwiftUI

struct MusicView: View {
    @State private var ExtendMusicView = false
    var body: some View {
        VStack{
            Image(.waitAlbum)
                .resizable()
                //.aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                //.frame(width: 370, height: 200)
            HStack{
                Text("Music Title")
                    .bold()
                Spacer()
                Image(systemName: "waveform")
            }
            HStack{
                Text("Artist")
                    .bold()
                Spacer()
            }
            Button{
                ExtendMusicView = true
            }label: {
                Text("Open Apple Music")
                    .foregroundStyle(.blue)
            }
            
        }
        .padding(.horizontal)
        .padding(.vertical, -25)
        .frame(maxWidth: 360, maxHeight: 320)
        .font(.title2)
        .foregroundStyle(.fill)
        .background(.ultraThinMaterial.opacity(0))
        .sheet(isPresented: $ExtendMusicView) {
            ExtendedMusicView()
        }
        
    }
}

#Preview {
    MusicView()
}
