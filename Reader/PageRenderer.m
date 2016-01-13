//
//  PageRenderer.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "PageRenderer.h"
#import "Page.h"
#import "Phrase.h"

@implementation PageRenderer

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark Public

- (void)render:(Page *)page inContext:(CGContextRef)ctx bounds:(CGRect)bounds; {
    TDAssertMainThread();
    
    
}

@end
