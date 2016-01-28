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
#define TOLERANCE 10.0
#define PHRASE_MARGIN_RATIO 0.1

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

static NSAttributedString *TDStringBinarySearch(NSString *txt, CGFloat availWidth, double hi, double lo, NSInteger count) {
    //NSLog(@"%@", @(++count));
    double mid = round(lo + (hi-lo)*0.5);
    BOOL bail = NO;
    
    if (mid <= MIN_FONT_SIZE+1.0) {
        bail = YES;
        mid = MIN_FONT_SIZE;
    }
    
    NSFont *font = [NSFont systemFontOfSize:mid];
    sAttrs[NSFontAttributeName] = font;
    
    NSAttributedString *str = [[[NSAttributedString alloc] initWithString:txt attributes:sAttrs] autorelease];
    CGSize size = [str size];
    
    CGFloat diff = size.width - availWidth;
    
    if (bail || fabs(diff) <= TOLERANCE) {
        return str;
    } else if (diff > TOLERANCE) {
        return TDStringBinarySearch(txt, availWidth, mid, lo, count);
    } else {
        TDCAssert(diff < 0.0 && fabs(diff) > TOLERANCE);
        return TDStringBinarySearch(txt, availWidth, hi, mid, count);
    }
}


- (void)render:(Page *)page inContext:(CGContextRef)ctx bounds:(CGRect)bounds {
    TDAssertMainThread();
    
    NSUInteger phraseCount = [page.phrases count];
    CGFloat availWidth = round(CGRectGetWidth(bounds));
    CGFloat phraseMargin = availWidth * PHRASE_MARGIN_RATIO;
    CGRect textRect = CGRectZero;
    
    // Calculate total text rect
    {
        CGFloat totalPhraseMargin = ((phraseCount-1) * phraseMargin);

        NSString *txt = [page phraseText];
        NSAttributedString *str = TDStringBinarySearch(txt, availWidth-(IMG_MARGIN*4.0 + totalPhraseMargin), 200.0, MIN_FONT_SIZE, 0);
        CGSize size = [str size];
        CGFloat strWidth = size.width + totalPhraseMargin;
        textRect = CGRectMake(round(CGRectGetMidX(bounds)-strWidth*0.5), round(CGRectGetHeight(bounds)*0.75-size.height), round(strWidth), round(size.height));
        //CGContextStrokeRect(ctx, textRect);

    }
    
    // Calculate phrase and img rects
    {
        CGRect phraseRects[phraseCount];
        CGRect imgRects[phraseCount];
        CGFloat minImgExtent = MAXFLOAT;
        
        {
            CGFloat x = CGRectGetMinX(textRect);
            CGFloat y = CGRectGetMinY(textRect);
            CGFloat maxExtent = y - CGRectGetMinY(bounds);
            
            NSUInteger i = 0;
            for (Phrase *phrase in page.phrases) {
                NSAttributedString *subStr = [[[NSAttributedString alloc] initWithString:phrase.text attributes:sAttrs] autorelease];
                CGSize size = [subStr size];
                
                // relative x-fudge needed here to offset apple's text drawing api
                CGRect phraseRect = CGRectMake(x + size.width*0.05, y, size.width, size.height);
                phraseRects[i] = phraseRect;
                
                CGFloat extent = round(MIN(size.width, maxExtent));
                
                CGRect imgRect = CGRectInset(CGRectMake(x, y-extent, extent, extent), IMG_MARGIN, IMG_MARGIN);
                imgRects[i] = imgRect;
                
                x += size.width + phraseMargin;
                
                minImgExtent = MIN(minImgExtent, extent);
                ++i;
            }
        }
        
        // Draw
        {
            NSUInteger i = 0;
            for (Phrase *phrase in page.phrases) {
                CGRect phraseRect = phraseRects[i];
                CGRect imgRect = imgRects[i];
                
                imgRect = CGRectMake(round(CGRectGetMidX(phraseRect)-minImgExtent*0.5), CGRectGetMaxY(imgRect)-minImgExtent, minImgExtent, minImgExtent);
                imgRects[i] = imgRect;

                //CGContextStrokeRect(ctx, phraseRect);
                //CGContextStrokeRect(ctx, imgRect);
                
                NSString *imgName = phrase.imageName;
                NSImage *img = [NSImage imageNamed:imgName];
                
                if (img) {
                    [img drawInRect:imgRect];
                } else {
                    NSLog(@"could not find image named: %@", imgName);
                }
                
                NSAttributedString *str = [[[NSAttributedString alloc] initWithString:phrase.text attributes:sAttrs] autorelease];
                [str drawInRect:phraseRect];

                ++i;
            }
        }
    }
}

@end
