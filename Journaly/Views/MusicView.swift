//
//  MusicView.swift
//  Journaly
//
//  Created by David Adekunle on 26/04/2025.
//

import SwiftUI
import MusicKit

struct MusicView: View {
    @State private var ExtendMusicView = false
    @State private var MusicSongTitle = "Music Title"
    @State private var MusicArtistName = "Artist Name"
    @State private var MusicArtworkURL: URL?
    var body: some View {
        VStack{
            if let MusicArtUrl = MusicArtworkURL{
                AsyncImage(url: MusicArtUrl){ imagePhase in
                    switch imagePhase {
                    case .success(let image):
                        image
                            .resizable()
                            
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    case .failure(_):
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.red)
                    case .empty:
                        ProgressView    ()
                    @unknown default:
                        EmptyView()
                    }
                        
                        
                }
            }else{
                Image(.waitAlbum)
                    .resizable()
                //.aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                //.frame(width: 370, height: 200)
            }
            HStack{
                Text(MusicSongTitle)
                    .bold()
                Spacer()
                Image(systemName: "waveform")
            }
            HStack{
                Text(MusicArtistName)
                    .bold()
                Spacer()
            }
            Button{
                ExtendMusicView = true
                MusicAuth()
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
        .onAppear{
            MusicAuth()
        }
        
    }
    func MusicAuth(){
        Task {
            let status =  await MusicAuthorization.request()
            if status == .authorized{
                getMusic()
            } else{
                print("Denied")
            }
        }
    }
    
    func getMusic() {
        Task{
            let songRequest = MusicCatalogSearchRequest(term: "Wait Maroon 5 featuring a boogie wit da Hoodie", types: [Song.self])
            do{
                let response = try await songRequest.response()
                if let firstSong = response.songs.first{
                    print("Song found: \(firstSong.title) by \(firstSong.artistName)")
                    
                    MusicSongTitle = firstSong.title
                    MusicArtistName = firstSong.artistName
                    if let MusicArtwork = firstSong.artwork{
                        MusicArtworkURL = MusicArtwork.url(width: 400, height: 300)
                    }
                    
                    let player = ApplicationMusicPlayer.shared
                    do{
                        try await player.queue.insert(firstSong, position: .afterCurrentEntry)
                        try await player.play()
                    } catch{
                        print("could not play song \(error.localizedDescription)")
                    }
                } else{
                    print("No song found")
                }
            } catch{
                print("Error fetching song: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    MusicView()
}
