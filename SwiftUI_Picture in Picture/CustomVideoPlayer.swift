//
//  CustomVideoPlayer.swift
//  SwiftUI_Picture in Picture
//
//  Created by computer on 2022/8/18.
//

import Foundation
import AVKit
import SwiftUI
import UIKit
import Combine
import AVFoundation

struct CustomVideoPlayer: UIViewRepresentable {
    @ObservedObject var model: ViewModel
    
    func makeUIView(context: Context) -> some UIView {
        let view = PlayerView()
        view.player = model.player
        context.coordinator.setController(view.playerLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
    func makeCoordinator() -> Coorinator {
        return Coorinator(self)
    }
    
    class Coorinator: NSObject, AVPictureInPictureControllerDelegate {
        private var parent: CustomVideoPlayer
        private var controller: AVPictureInPictureController?
        private var cancellable: AnyCancellable?
        
        init(_ parent: CustomVideoPlayer) {
            self.parent = parent
            super.init()
            self.cancellable = parent.model.$isInPip
                .sink { value in
                    guard let controller = self.controller else {
                        return
                    }
                    
                    if value && controller.isPictureInPictureActive == false  {
                        controller.startPictureInPicture()
                    } else {
                        controller.stopPictureInPicture()
                    }
                }
        }
        
        func setController(_ plyaerLayer: AVPlayerLayer) {
            controller = AVPictureInPictureController(playerLayer: plyaerLayer)
            controller?.canStartPictureInPictureAutomaticallyFromInline = true
            controller?.delegate = self
        }
        
        func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
            parent.model.isInPip = true
        }
        
        func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
            parent.model.isInPip = false
        }
    }
}
