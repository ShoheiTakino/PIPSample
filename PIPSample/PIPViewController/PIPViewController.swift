//
//  PIPViewController.swift
//  PIPSample
//
//  Created by 滝野翔平 on 2023/05/27.
//

import UIKit
import AVKit

final class PIPViewController: UIViewController {
    
    var playerLayer: AVPlayerLayer!
    var pictureInPictureController: AVPictureInPictureController!
    let backgroundView: UIView = {
        let view = UIView()
//        let panGesture = UIPanGestureRecognizer(target: view, action: #selector(handlePanGesture(_:)))
//        view.addGestureRecognizer(panGesture)
        return view
    }()
    
    // MARK: - IBAction
    
    @IBAction private func tappedDismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func tappedStartPIPButton() {
//        guard let videoURL = Bundle.main.url(forResource: "pip_demo_video", withExtension: "mp4") else { return }
//        let player = AVPlayer(url: videoURL)
//        playerLayer = AVPlayerLayer(player: player)
//
//        pictureInPictureController = AVPictureInPictureController(playerLayer: playerLayer)
//        pictureInPictureController.delegate = self
//
//        playerLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        backgroundView.layer.addSublayer(playerLayer)
////        view.layer.addSublayer(playerLayer)
//        view?.addSubview(backgroundView)
//        view?.layer.cornerRadius = 30
//        player.play()
//        pictureInPictureController.startPictureInPicture()
        guard let videoURL = Bundle.main.url(forResource: "pip_demo_video", withExtension: "mp4") else { return }
        let player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        backgroundView.addGestureRecognizer(panGesture)

        pictureInPictureController = AVPictureInPictureController(playerLayer: playerLayer)
        pictureInPictureController.delegate = self
        
        playerLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        backgroundView.layer.addSublayer(playerLayer)
        backgroundView.frame = CGRect(x: 0, y: 0, width: 200, height: 200) // backgroundViewのフレームを設定
        
        view.addSubview(backgroundView) // backgroundViewをviewに追加
        backgroundView.center = view.center // backgroundViewを中央に配置
        backgroundView.layer.cornerRadius = 30
        player.play()
        pictureInPictureController.startPictureInPicture()
    }
    
    @IBAction private func tappedStopPIPButton() {
        pictureInPictureController.stopPictureInPicture()
        //        PIPManager.share.stopPIPScreen()
    }
}

// MARK: - AVPictureInPictureControllerDelegate

extension PIPViewController: AVPictureInPictureControllerDelegate {
    
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        // ピクチャーインピクチャーモードが終了した時の処理
    }
    
    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        // ピクチャーインピクチャーモードが終了する直前の処理
    }
}

// MARK: - Private

private extension PIPViewController {
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        print(#function)
        guard let window = gestureRecognizer.view?.window else {
            return
        }
        
        let translation = gestureRecognizer.translation(in: window)
        
        switch gestureRecognizer.state {
        case .began:
            // ドラッグ開始時の処理
            gestureRecognizer.setTranslation(.zero, in: window)
            
        case .changed:
            // ドラッグ中の処理
            let updatedOrigin = CGPoint(x: window.frame.origin.x + translation.x, y: window.frame.origin.y + translation.y)
            window.frame = CGRect(origin: updatedOrigin, size: window.frame.size)
            
            gestureRecognizer.setTranslation(.zero, in: window)
            
        case .ended, .cancelled, .failed:
            // ドラッグ終了時の処理
            break
            
        default:
            break
        }
    }
}
