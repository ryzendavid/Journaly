//
//  audioManager.swift
//  Journaly
//
//  Created by David Adekunle on 27/03/2025.
//

import Foundation
import AVFoundation


class AudioManager: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false

    // Load an audio file from the app bundle.
    func loadSound(named soundName: String, fileType: String = "mp3") {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: fileType) else {
            print("Unable to find sound file: \(soundName).\(fileType)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
    }
    
    // Toggle playback, playing or pausing the sound.
    func togglePlayback() {
        guard let player = audioPlayer else {
            return
        }
        
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
}
