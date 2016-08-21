//
//  PageRenderer.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "PageRenderer.h"
#import "Page.h"
#import "Run.h"
#import "Phrase.h"

#define MIN_FONT_SIZE 16.0
#define RUN_MARGIN_Y_RATIO 0.1
#define IMG_MARGIN 10.0
#define TOLERANCE 10.0
#define PHRASE_MARGIN_RATIO 0.1

static NSMutableDictionary *sAttrs = nil;

@implementation PageRenderer

+ (void)initialize {
    if ([PageRenderer class] == self) {
        id paraStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
        [paraStyle setAlignment:NSTextAlignmentCenter];
        [paraStyle setLineBreakMode:NSLineBreakByClipping];
        
        sAttrs = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                  [FONT_CLASS systemFontOfSize:10.0], NSFontAttributeName,
                  [COLOR_CLASS blackColor], NSForegroundColorAttributeName,
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

static CGFloat TDStringBinarySearch(NSString *txt, CGFloat availWidth, double hi, double lo, NSInteger count) {
    //NSLog(@"%@", @(++count));
    double mid = round(lo + (hi-lo)*0.5);
    BOOL bail = NO;
    
    if (fabs(hi - lo) < 2.0) {
        bail = YES;
        mid = lo;
    } else if (mid <= MIN_FONT_SIZE+1.0) {
        bail = YES;
        mid = MIN_FONT_SIZE;
    }
    
    id font = [FONT_CLASS systemFontOfSize:mid];
    sAttrs[NSFontAttributeName] = font;
    
    NSAttributedString *str = [[[NSAttributedString alloc] initWithString:txt attributes:sAttrs] autorelease];
    CGSize size = [str size];
    
    CGFloat diff = size.width - availWidth;
    
    if (bail || fabs(diff) <= TOLERANCE) {
        return mid;
    } else if (diff > TOLERANCE) {
        return TDStringBinarySearch(txt, availWidth, mid, lo, count);
    } else {
        TDCAssert(diff < 0.0 && fabs(diff) > TOLERANCE);
        return TDStringBinarySearch(txt, availWidth, hi, mid, count);
    }
}


- (void)renderPage:(Page *)page inContext:(CGContextRef)ctx rect:(CGRect)bounds {
    TDAssertMainThread();
    
    NSArray *runs = [page makeRuns];
    NSUInteger runCount = [runs count];

    CGFloat runHeight = CGRectGetHeight(bounds) / runCount;
    CGFloat availHeight = CGRectGetHeight(bounds) - (RUN_MARGIN_Y_RATIO*runHeight)*(runCount-1);
    runHeight = availHeight / runCount;
    CGFloat y = CGRectGetMinY(bounds);
    
    // get font size
    {
        CGFloat fontSize = MAXFLOAT;
        for (Run *run in runs) {
            CGRect r = CGRectMake(CGRectGetMinX(bounds), y, CGRectGetWidth(bounds), runHeight);
            
            NSUInteger phraseCount = [run.phrases count];
            CGFloat availWidth = round(CGRectGetWidth(r));
            CGFloat phraseMargin = availWidth * PHRASE_MARGIN_RATIO;
            
            // Calculate total text rect
            {
                CGFloat totalPhraseMargin = ((phraseCount-1) * phraseMargin);
                
                NSString *txt = [run phraseText];
                CGFloat currFontSize = TDStringBinarySearch(txt, availWidth-(IMG_MARGIN*4.0 + totalPhraseMargin), 200.0, MIN_FONT_SIZE, 0);
                fontSize = MIN(fontSize, currFontSize);
            }
        }
        
        id font = [FONT_CLASS systemFontOfSize:fontSize];
        sAttrs[NSFontAttributeName] = font;
    }

    // render runs
    for (Run *run in runs) {

        CGRect r = CGRectMake(CGRectGetMinX(bounds), y, CGRectGetWidth(bounds), runHeight);
        //CGContextStrokeRect(ctx, r);
        
        [self renderRun:run inContext:ctx rect:r];
        
        y += runHeight + RUN_MARGIN_Y_RATIO*runHeight;
    }
}



- (void)renderRun:(Run *)run inContext:(CGContextRef)ctx rect:(CGRect)r {
    NSUInteger phraseCount = [run.phrases count];
    CGFloat availWidth = round(CGRectGetWidth(r));
    CGFloat phraseMargin = availWidth * PHRASE_MARGIN_RATIO;
    CGRect textRect = CGRectZero;
    
    // Calculate total text rect
    {
        CGFloat totalPhraseMargin = ((phraseCount-1) * phraseMargin);

        NSString *txt = [run phraseText];
        NSAttributedString *str = [[[NSAttributedString alloc] initWithString:txt attributes:sAttrs] autorelease];
        CGSize size = [str size];
        CGFloat strWidth = size.width + totalPhraseMargin;
        textRect = CGRectMake(round(CGRectGetMidX(r)-strWidth*0.5), round(CGRectGetMinY(r)+CGRectGetHeight(r)-size.height), round(strWidth), round(size.height));
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
            CGFloat maxExtent = y - CGRectGetMinY(r);
            CGFloat imgFudge = CGRectGetHeight(textRect)*0.2;
            
            NSUInteger i = 0;
            for (Phrase *phrase in run.phrases) {
                NSAttributedString *subStr = [[[NSAttributedString alloc] initWithString:phrase.text attributes:sAttrs] autorelease];
                CGSize strSize = [subStr size];
                
                // relative x-fudge needed here to offset apple's text drawing api
                CGRect phraseRect = CGRectMake(x + strSize.width*0.05, y, strSize.width, strSize.height);
                phraseRects[i] = phraseRect;
                
                CGFloat extent = round(MIN(strSize.width, maxExtent));
                
                CGRect imgRect = CGRectInset(CGRectMake(x, y-extent+imgFudge, extent, extent), IMG_MARGIN, IMG_MARGIN);
                imgRects[i] = imgRect;

                x += strSize.width + phraseMargin;
                
                if (phrase.imageName) {
                    minImgExtent = MIN(minImgExtent, extent);
                }
                ++i;
            }
        }
        
        // Draw
        {
            NSUInteger i = 0;
            for (Phrase *phrase in run.phrases) {
                CGRect phraseRect = phraseRects[i];
                CGRect imgRect = imgRects[i];
                
                imgRect = CGRectMake(round(CGRectGetMidX(phraseRect)-minImgExtent*0.5), CGRectGetMaxY(imgRect)-minImgExtent, minImgExtent, minImgExtent);
                imgRects[i] = imgRect;
                
                {
                    CGFloat totalHeight = CGRectGetHeight(imgRect) + CGRectGetHeight(phraseRect);
                    CGFloat midY = CGRectGetMidY(r);
                    imgRect.origin.y = midY - totalHeight*0.5;
                    phraseRect.origin.y = midY + totalHeight*0.5 - phraseRect.size.height;
                }

                //CGContextStrokeRect(ctx, phraseRect);
                //CGContextStrokeRect(ctx, imgRect);
                
                NSString *imgName = phrase.imageName;
                if (imgName) {
                    id img = [IMAGE_CLASS imageNamed:imgName];
                    
                    if (img) {
                        [(id)img drawInRect:imgRect];
                    } else {
                        NSLog(@"could not find image named: %@", imgName);
                    }
                }
                
                NSAttributedString *str = [[[NSAttributedString alloc] initWithString:phrase.text attributes:sAttrs] autorelease];
                [str drawInRect:phraseRect];

                ++i;
            }
        }
    }
}

@end
