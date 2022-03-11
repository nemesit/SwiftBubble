//
//  SwiftBubbleView.swift
//  SwiftBubble
//
//  Created by Felix Grabowski on 30/05/15.
//  Copyright (c) 2015 Felix Grabowski. All rights reserved.
//


import ScreenSaver
import AVFoundation
import AVKit
import SwiftUI

@available(OSX 10.15, *)
@objc(SwiftBubbleView)
public class SwiftBubbleView: ScreenSaverView {

   @objc public var onDidChange: ((Float) -> Void)?

  public override init(frame frameRect: NSRect, isPreview: Bool) {
    super.init(frame: frameRect, isPreview: isPreview)!
      wantsLayer = true
      layer?.backgroundColor = NSColor.lightGray.cgColor
      let view = NSHostingView(rootView: SwiftBubbleVideoView())
      view.translatesAutoresizingMaskIntoConstraints = false
      addSubview(view)
      leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
      trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
      topAnchor.constraint(equalTo: view.topAnchor).isActive = true
      bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
   }
  
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
}
struct SwiftBubbleVideoView: View {
  
  var playerItem: AVPlayerItem
  var player: AVQueuePlayer
  var looper: AVPlayerLooper
  
  init() {
//    playerItem = AVPlayerItem(asset: AVAsset(url: Bundle(for: SwiftBubbleView.self).url(forResource: "SwiftBubble", withExtension: "mov")!))
    playerItem = AVPlayerItem(asset: AVAsset(url: Bundle(for: SwiftBubbleView.self).url(forResource: "swiftbubble_deblocked", withExtension: "m4v")!))

    player = AVQueuePlayer(playerItem: playerItem)
    looper = AVPlayerLooper(player: player, templateItem: playerItem)
  }
  
  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .bottom) {
        VideoPlayer.init(player: player)
          .scaleEffect(CGSize(width: 0.7, height: 0.7))
          .onAppear() { player.play() }
          .onDisappear() { player.pause() }
        VStack(alignment: .leading) {
          Color.clear
          Color.black
            .frame(width: geometry.size.width, height: geometry.size.height * 0.17, alignment: .bottom)
        }
      }
    }
  }
}

