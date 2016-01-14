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

static NSMutableDictionary *sAttrs = nil;

@implementation PageRenderer

+ (void)initialize {
    if ([PageRenderer class] == self) {
        id paraStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
        [paraStyle setAlignment:NSCenterTextAlignment];
        [paraStyle setLineBreakMode:NSLineBreakByClipping];
        
        sAttrs = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                  [NSFont systemFontOfSize:10.0], NSFontAttributeName,
                  [NSColor blackColor], NSForegroundColorAttributeName,
                  paraStyle, NSParagraphStyleAttributeName,
                  nil];
    }
}


- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark Public

- (void)render:(Page *)page inContext:(CGContextRef)ctx bounds:(CGRect)bounds {
    TDAssertMainThread();
    
    NSString *txt = [page phraseText];
    NSAttributedString *str = [[[NSAttributedString alloc] initWithString:txt attributes:sAttrs] autorelease];
    CGSize size = [str size];
    
    [str drawInRect:CGRectMake(CGRectGetMinX(bounds), CGRectGetMidY(bounds)-size.height*0.5, CGRectGetWidth(bounds), size.height)];
    
}

@end
