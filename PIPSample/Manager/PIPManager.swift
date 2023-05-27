//
//  PIPManager.swift
//  PIPSample
//
//  Created by 滝野翔平 on 2023/05/27.
//

import UIKit
import AVKit

final class PIPManager: UIViewController {
    
    init() {
        super.init(nibName:  nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let share = PIPManager()
    private let playerViewController = AVPlayerViewController()
    private let pictureView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    func playPIPScreen(view: UIView) {
        let playerViewController = AVPlayerViewController()
        let viewPlayer = AVPlayer(url: Bundle.main.url(forResource: "pip_demo_video", withExtension: "mp4")!)
        
        let playerLayer = AVPlayerLayer(player: viewPlayer)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        pictureView.image = UIImage(named: "yourImage")
        pictureView.layer.addSublayer(playerLayer)
        viewPlayer.play()
        
        playerViewController.player = viewPlayer
        playerViewController.allowsPictureInPicturePlayback = true
        
        present(playerViewController, animated: true, completion: nil)
    }
    
    func stopPIPScreen() {
        dismiss(animated: true, completion: nil)
    }
}
