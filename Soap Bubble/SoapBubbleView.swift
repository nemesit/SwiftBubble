//
//  File.swift
//  Soap Bubble
//
//  Created by Felix Grabowski on 26/05/15.
//  Copyright (c) 2015 Felix Grabowski. All rights reserved.
//

import ScreenSaver
import Quartz

var qtz:QCView?

class SoapBubbleView : ScreenSaverView {
    convenience init() {
        self.init(frame: CGRectZero, isPreview: false)
    }
    
    override init(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        setAnimationTimeInterval(1.0 / 30.0)
        var qtzComposition = NSBundle(forClass: self.dynamicType).pathForResource("SoapBubble", ofType: "qtz")
        if let comp = qtzComposition {
            qtz = QCView(frame: NSMakeRect(0, 0, NSWidth(frame), NSHeight(frame)))
            if qtz != nil {
                qtz!.loadCompositionFromFile(qtzComposition)
                qtz!.setMaxRenderingFrameRate(30.0)
                self.addSubview(qtz!)
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func startAnimation() {
        qtz!.startRendering()
        super.startAnimation()
    }
    
    override func stopAnimation() {
        qtz!.stopRendering()
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
}
