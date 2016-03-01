//
//  PageView.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "PageView.h"

@implementation PageView

- (void)dealloc {
    self.pageRenderer = nil;
    self.page = nil;
    [super dealloc];
}


- (BOOL)isFlipped {
    return YES;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (!_page) return;

    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    TDAssert(_pageRenderer);
    [_pageRenderer renderPage:_page inContext:ctx rect:[self bounds]];
}

@end
