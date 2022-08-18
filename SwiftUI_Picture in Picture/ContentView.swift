//
//  ContentView.swift
//  SwiftUI_Picture in Picture
//
//  Created by computer on 2022/8/18.
//

import SwiftUI
import AVKit
import AVFoundation

struct ContentView: View {
    @StateObject var model = ViewModel()
    
    init() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            CustomVideoPlayer(model: model)
                .frame(height: UIScreen.main.bounds.height * 0.4)
                .padding(.bottom)
            
            Button(action: model.enterPip, label: {
                Text("Enter PiP")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
            })
            .alert(isPresented: $model.isShowDontSupportPipAlert, content: {
                Alert(title: Text("Error"), message: Text("Your device don't support picture in picture"), dismissButton: .cancel())
            })
            
            Spacer()
        }
        .onAppear {
            model.player.play()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
