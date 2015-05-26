//
//  Soap_BubbleView.m
//  Soap Bubble
//
//  Created by Felix Grabowski on 25/05/15.
//  Copyright (c) 2015 Felix Grabowski. All rights reserved.
//

#import "Soap_BubbleView.h"

@implementation Soap_BubbleView

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self setAnimationTimeInterval:1/30.0];
        NSString *qtzComposition = [[NSBundle bundleForClass:[self class]] pathForResource:@"SoapBubble" ofType:@"qtz"];
        if (qtzComposition) {
            qtz = [[QCView alloc] initWithFrame: NSMakeRect(0, 0, NSWidth(frame), NSHeight(frame))];
            if (qtz) {
                [qtz loadCompositionFromFile:qtzComposition];
                [qtz setMaxRenderingFrameRate: 30.0f];
                [self addSubview:qtz];
            }
        }
    }
    return self;
}

- (void)startAnimation
{
    [qtz startRendering];
    [super startAnimation];
}

- (void)stopAnimation
{
    [qtz stopRendering];
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

@end
