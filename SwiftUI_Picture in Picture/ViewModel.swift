//
//  ViewModel.swift
//  SwiftUI_Picture in Picture
//
//  Created by computer on 2022/8/18.
//

import Foundation
import AVKit
import AVFoundation

final class ViewModel: ObservableObject {
    @Published var isInPip = false
    @Published var isShowDontSupportPipAlert = false
    let player = AVPlayer(url: URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!)
    
    private func isSupportPip() -> Bool {
        return AVPictureInPictureController.isPictureInPictureSupported()
    }
    
    func enterPip() {
        if !isSupportPip() {
            isShowDontSupportPipAlert = true
            return
        }
        
        isInPip.toggle()
    }
}
