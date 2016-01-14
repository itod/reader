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

#define MIN_FONT_SIZE 16.0

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

static NSAttributedString *TDStringSearch(NSString *txt, CGFloat availWidth, double hi, double lo) {
    double mid = round(lo + (hi-lo)*0.5);
    BOOL bail = mid <= MIN_FONT_SIZE+1.0;
    if (bail) {
        mid = MIN_FONT_SIZE;
    }
    
    NSFont *font = [NSFont systemFontOfSize:mid];
    sAttrs[NSFontAttributeName] = font;
    
    NSAttributedString *str = [[[NSAttributedString alloc] initWithString:txt attributes:sAttrs] autorelease];
    CGSize size = [str size];
    
    if (bail || size.width < availWidth) {
        return str;
    } else {
        return TDStringSearch(txt, availWidth, hi*0.75, lo);
    }
}


- (void)render:(Page *)page inContext:(CGContextRef)ctx bounds:(CGRect)bounds {
    TDAssertMainThread();
    
    CGFloat availWidth = round(CGRectGetWidth(bounds));
    
    NSString *txt = [page phraseText];
    
    NSAttributedString *str = TDStringSearch(txt, availWidth, 200.0, MIN_FONT_SIZE);
    CGSize size = [str size];

    [str drawInRect:CGRectMake(CGRectGetMinX(bounds), CGRectGetMidY(bounds)-size.height*0.5, CGRectGetWidth(bounds), size.height)];
    
}

@end
