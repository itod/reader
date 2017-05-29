//
//  PrevNextButton.m
//  Reader
//
//  Created by Todd Ditchendorf on 5/28/17.
//  Copyright © 2017 Todd Ditchendorf. All rights reserved.
//

#import "PrevNextButton.h"

#define WIDTH 20.0
#define HEIGHT 30.0

@implementation PrevNextButton

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect iconRect = [self iconRectForBounds:self.bounds];
    
    if ([self tag]) {
        CGContextMoveToPoint(ctx, CGRectGetMinX(iconRect), CGRectGetMinY(iconRect));
        CGContextAddLineToPoint(ctx, CGRectGetMinX(iconRect), CGRectGetMaxY(iconRect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(iconRect), CGRectGetMidY(iconRect));
    } else {
        CGContextMoveToPoint(ctx, CGRectGetMaxX(iconRect), CGRectGetMinY(iconRect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(iconRect), CGRectGetMaxY(iconRect));
        CGContextAddLineToPoint(ctx, CGRectGetMinX(iconRect), CGRectGetMidY(iconRect));
    }

    CGContextClosePath(ctx);

    CGContextSetGrayFillColor(ctx, 0.7, 1.0);
    CGContextFillPath(ctx);
}


- (CGRect)iconRectForBounds:(CGRect)bounds {
    CGFloat x = round(CGRectGetMidX(bounds) - WIDTH*0.5);
    CGFloat y = round(CGRectGetMidY(bounds) - HEIGHT*0.5);
    CGFloat w = WIDTH;
    CGFloat h = HEIGHT;
    
    CGRect r = CGRectMake(x, y, w, h);
    return r;
}

@end
