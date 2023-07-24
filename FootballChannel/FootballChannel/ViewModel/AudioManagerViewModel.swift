//
//  AudioManagerViewModel.swift
//  FootballChannel
//
//  Created by Kno Harutyunyan on 09.07.23.
//

import Foundation
import AVKit

class AudioManagerViewModel {
    private var chantAudioPlayer: AVAudioPlayer?
    
    func playback(_ team: Team){
        if team.isPlaying {
            chantAudioPlayer?.stop()
        } else {
            guard let path = Bundle.main.path(forResource: "\(team.id.chantFile).mp3", ofType: nil) else {
                return
            }
            let url = URL(fileURLWithPath: path)
            print(url)
            do {
                chantAudioPlayer = try AVAudioPlayer(contentsOf: url)
                chantAudioPlayer?.numberOfLoops = -1
                chantAudioPlayer?.play()
            } catch {
                print(error)
            }
        }
    }
}
