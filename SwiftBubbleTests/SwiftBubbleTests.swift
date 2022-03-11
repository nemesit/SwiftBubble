//
//  SwiftBubbleTests.swift
//  SwiftBubbleTests
//
//  Created by Felix Grabowski on 30/05/15.
//  Copyright (c) 2015 Felix Grabowski. All rights reserved.
//

import Cocoa
import XCTest
import AVFoundation


var player:AVPlayer?

class SwiftBubbleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let filePath = NSBundle(forClass: self.dynamicType).pathForResource("SoapBubble1080p", ofType: "mov")
        if filePath != nil {
            let fileURL = NSURL(fileURLWithPath: filePath!)
            
            player = AVPlayer(URL: fileURL)
        }
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        player!.play()
        XCTAssert(player != nil, "player successfully created")
        //XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
