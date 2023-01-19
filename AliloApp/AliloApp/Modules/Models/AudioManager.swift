//
//  AudioPlayer.swift
//  AliloApp
//
//  Created by Виктор Куля on 23.08.2022.
//

import Foundation
import AVFoundation

class AudioManager {
        
    private var player: AVQueuePlayer?
    private var avItems = [AVPlayerItem]()
    
    private var soundPathsArray = [
        Bundle.main.path(forResource: "mixkit-cartoon-dazzle-hit-and-birds-746", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-cartoon-failure-piano-473", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-cartoon-falling-whistle-395", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-cartoon-fart-sound-2891", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-cartoon-toy-whistle-616", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-cartoon-voice-laugh-343", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-clown-horn-at-circus-715", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-drum-joke-accent-579", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-falling-male-scream-391", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-funny-break-engine-2944", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-funny-cartoon-melody-2881", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-happy-party-horn-sound-530", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-joke-drums-578", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-laughing-teenagers-429", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-metallic-boing-hit-2895", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-quick-funny-kiss-2193", ofType: "wav"),
        Bundle.main.path(forResource: "mixkit-sad-game-over-trombone-471", ofType: "wav")
    ]
    
    private var songsPathsArray = [
        Bundle.main.path(forResource: "deti-online.com_-_bu-ra-ti-no-priklyucheniya-buratino", ofType: "mp3"),
        Bundle.main.path(forResource: "deti-online.com_-_kaby-ne-bylo-zimy-zima-v-prostokvashino", ofType: "mp3"),
        Bundle.main.path(forResource: "deti-online.com_-_pesenka-krokodila-geny-pust-begut-neuklyuzhe5", ofType: "mp3"),
        Bundle.main.path(forResource: "deti-online.com_-_pesenka-lvenka-i-cherepahi-kak-lvenok-i-cherepaha-peli-pesnyu", ofType: "mp3"),
        Bundle.main.path(forResource: "deti-online.com_-_pesenka-vinni-puha-vinni-puh-i-vse-vse-vse", ofType: "mp3"),
        Bundle.main.path(forResource: "deti-online.com_-_pesnya-mamontenka", ofType: "mp3"),
        Bundle.main.path(forResource: "deti-online.com_-_ulybka-kroshka-enot", ofType: "mp3")
    ]

    func play(mode: PlayerType) {
        let pathes: [String?] = {
            switch mode {
            case .sound: return soundPathsArray
            case .song: return songsPathsArray
            }
        }()
        let urls = pathes.compactMap { $0 }.compactMap { URL(fileURLWithPath: $0) }
        avItems = urls.map { AVPlayerItem(url: $0) }
        let player = AVQueuePlayer(items: avItems)
        player.play()
        self.player = player
    }

    func destroyPlayer() {
        player?.pause()
        player?.removeAllItems()
        player = nil
        avItems = []
    }
    
    func playNextAudio(mode: inout PlayerType) {

        var melodyIndex: Int?
        for item in 0..<avItems.count {
            if player?.currentItem == avItems[item] {
                melodyIndex = item
            }
        }
        if melodyIndex != nil {
            if (melodyIndex! + 1) < avItems.count {
                player?.advanceToNextItem()
            } else {
                changeModeAndPlayNextAudio(mode: &mode)
            }
        }

    }
    
    private func changeModeAndPlayNextAudio(mode: inout PlayerType) {
        switch mode {
        case .sound:
            mode = .song
            play(mode: mode)
            print("Play song")
        case .song:
            mode = .sound
            play(mode: mode)
            print("Play sound")
        }
    }
}
