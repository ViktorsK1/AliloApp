//
//  ViewController.swift
//  AliloApp
//
//  Created by Виктор Куля on 16.08.2022.
//

import UIKit
//import AVFoundation

//enum AudioManager: String {
//    case sound = "mp3"
//    case song = "wav"
//}

class GameViewController: UIViewController {

    // MARK: - Properties
    private let gameView = GameView()
    private var playerType: PlayerType = .sound
    private let audioManager = AudioManager()
    
    // MARK: - View lifecycle
    override func loadView() {
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        audioManager.play(mode: playerType)
    }

    // MARK: - Actions
    private func typeDidChanged() {
        switch playerType {
        case .sound:
            gameView.stopEarsAnimation()
            
        case .song:
            gameView.startEarsAnimation()
        }
        audioManager.destroyPlayer()
        audioManager.play(mode: playerType)
    }
    
    private func melodyDidChanged() {
        audioManager.playNextAudio(mode: &playerType)
    }
}

// MARK: - GameViewDelegate
extension GameViewController: GameViewDelegate {
    func didTapChangeMode() {
        switch playerType {
        case .sound:
            playerType = .song
            print("Play song")
        case .song:
            playerType = .sound
            print("Play sound")
        }
        typeDidChanged()
    }
    
    func didTapChangeMelody() {
        melodyDidChanged()
    }
    
    func didCenteredOn(color: UIColor) {
        switch playerType {
        case .sound:
            gameView.updateEarsColor(color)
            
        case .song:
            break
        }
    }
}
