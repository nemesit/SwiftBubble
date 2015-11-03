//
//  ViewController.swift
//  VideoLoopTest
//
//  Created by Felix Grabowski on 30/05/15.
//  Copyright (c) 2015 Felix Grabowski. All rights reserved.
//

import Cocoa
import AVFoundation
import AVKit


class ViewController: NSViewController {

    @IBOutlet weak var videoView: AVPlayerView!
    var player:AVPlayer?
    let frameRate = 29.97
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var soapBubblePath = NSBundle(forClass: self.dynamicType).pathForResource("SwiftBubble", ofType: "mov")
        
        if soapBubblePath != nil {
            let fileURL = NSURL.fileURLWithPath(soapBubblePath!)
            let asset = AVAsset.assetWithURL(fileURL)  as? AVAsset
            let playerItem = AVPlayerItem(asset: asset)
            player = AVPlayer(playerItem: playerItem)
            let playerLayer = AVPlayerLayer(player: player!)
            playerLayer.frame = self.videoView.frame
            
            //nil layer
            //self.videoView.layer!.addSublayer(playerLayer)
            videoView.player = player
            //loop
            player!.actionAtItemEnd = .None
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "restartVideo", name: AVPlayerItemDidPlayToEndTimeNotification, object: player!.currentItem)
        }
        
        player!.play()
        
        // Do any additional setup after loading the view.
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func restartVideo() {
        let seconds:Int64 = 0
        let preferredTimeScale:Int32 = 1
        let seekTime:CMTime = CMTimeMake(seconds, preferredTimeScale)
        player!.seekToTime(seekTime)
        player!.play()
    }


}

