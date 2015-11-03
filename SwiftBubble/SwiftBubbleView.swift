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

class SoapBubbleView : ScreenSaverView {
    
    var videoView:AVPlayerView?
    let frameRate = 29.97
    var player:AVPlayer?
    
    convenience init() {
        self.init(frame: CGRectZero, isPreview: false)
    }
    
    override init!(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        self.animationTimeInterval = 1.0 / frameRate
        
        guard let soapBubblePath = NSBundle(forClass: self.dynamicType).pathForResource("SwiftBubble", ofType: "mov") else {
            fatalError("path to bubble not found")
        }
        
        let fileURL = NSURL.fileURLWithPath(soapBubblePath)
        let asset = AVAsset(URL: fileURL)//AVAsset.assetWithURL(fileURL)  as? AVAsset
        let playerItem = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player!)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        
        
        let videoView = AVPlayerView(frame: NSMakeRect(0, 0, NSWidth(frame)/2, NSHeight(frame)/2))

        
        centerView(videoView, inView: self)
        videoView.player = player
        videoView.controlsStyle = .None
        self.addSubview(videoView)
        
        //loop
        player!.actionAtItemEnd = .None
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func startAnimation() {
        player!.play()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "restartVideo", name: AVPlayerItemDidPlayToEndTimeNotification, object: player!.currentItem)
        super.startAnimation()
    }
    
    override func stopAnimation() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        super.stopAnimation()
    }
    
    override func drawRect(rect: NSRect) {
        super.drawRect(rect)
    }
    
    override func animateOneFrame() {
        
    }
    
    override func hasConfigureSheet() -> Bool {
        return false
    }
    
    override func configureSheet() -> NSWindow? {
        return nil
    }
    
    func restartVideo() {
        let seconds:Int64 = 0
        let preferredTimeScale:Int32 = 1
        let seekTime:CMTime = CMTimeMake(seconds, preferredTimeScale)
        player!.seekToTime(seekTime)
        player!.play()
    }
    
    func centerView(v1:NSView, inView v2:NSView) {
        
        v1.translatesAutoresizingMaskIntoConstraints = false
        v2.translatesAutoresizingMaskIntoConstraints = false
        let multiplier:CGFloat = 0.75 // video scaling
        let equalWidth = NSLayoutConstraint(item: v1,
                                       attribute:NSLayoutAttribute.Width,
                                       relatedBy:NSLayoutRelation.Equal,
                                          toItem:self,
                                       attribute:NSLayoutAttribute.Width,
                                      multiplier:multiplier,
                                        constant:0);
        let equalHeight = NSLayoutConstraint(item: v1,
                                        attribute:NSLayoutAttribute.Height,
                                        relatedBy:NSLayoutRelation.Equal,
                                           toItem:self,
                                        attribute:NSLayoutAttribute.Height,
                                       multiplier:multiplier,
                                         constant:0);
        let centerX = NSLayoutConstraint(item: v1,
                                    attribute:NSLayoutAttribute.CenterX,
                                    relatedBy:NSLayoutRelation.Equal,
                                       toItem:self,
                                    attribute:NSLayoutAttribute.CenterX,
                                   multiplier:1.0,
                                     constant:0);
        let centerY = NSLayoutConstraint(item: v1,
                                    attribute:NSLayoutAttribute.CenterY,
                                    relatedBy:NSLayoutRelation.Equal,
                                       toItem:self,
                                    attribute:NSLayoutAttribute.CenterY,
                                   multiplier:1.0,
                                     constant:0);
        
        v2.addConstraint(equalWidth)
        v2.addConstraint(equalHeight)
        v2.addConstraint(centerX)
        v2.addConstraint(centerY)
    }
}
