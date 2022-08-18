//
//  PlayerView.swift
//  SwiftUI_Picture in Picture
//
//  Created by computer on 2022/8/18.
//

import UIKit
import AVFoundation

final class PlayerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            playerLayer.player
        }
        set {
            playerLayer.videoGravity = .resizeAspect
            playerLayer.player = newValue
        }
    }
}
