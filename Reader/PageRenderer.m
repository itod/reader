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
#define IMG_MARGIN 10.0
#define FUDGE 10.0

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
    CGRect textRect = CGRectZero;
    
    // Text
    {
        NSString *txt = [page phraseText];
        NSAttributedString *str = TDStringSearch(txt, availWidth, 200.0, MIN_FONT_SIZE);
        CGSize size = [str size];
        textRect = CGRectMake(round(CGRectGetMidX(bounds)-size.width*0.5), round(CGRectGetHeight(bounds)*0.75-size.height), round(size.width), round(size.height));
        [str drawInRect:textRect];
    }
    
    // Images
    {
        CGFloat x = CGRectGetMinX(textRect);
        CGFloat y = CGRectGetMinY(textRect);
        CGFloat maxExtent = y - CGRectGetMinY(bounds);
        
        NSAttributedString *wsStr = [[[NSAttributedString alloc] initWithString:@" " attributes:sAttrs] autorelease];
        CGFloat wsWidth = [wsStr size].width;
        
        for (Phrase *phrase in page.phrases) {
            NSAttributedString *subStr = [[[NSAttributedString alloc] initWithString:phrase.text attributes:sAttrs] autorelease];
            CGSize size = [subStr size];
            CGRect phraseRect = CGRectMake(x+FUDGE, y, size.width, size.height);
            CGContextStrokeRect(ctx, phraseRect);
            
            CGFloat extent = round(MIN(size.width, maxExtent));
            
            CGRect imgRect = CGRectInset(CGRectMake(CGRectGetMinX(phraseRect), y-extent, extent, extent), IMG_MARGIN, IMG_MARGIN);
            CGContextStrokeRect(ctx, imgRect);
            
            x += size.width + wsWidth;
        }
    }
}

@end
