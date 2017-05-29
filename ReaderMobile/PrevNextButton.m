//
//  PrevNextButton.m
//  Reader
//
//  Created by Todd Ditchendorf on 5/28/17.
//  Copyright © 2017 Todd Ditchendorf. All rights reserved.
//

#import "PrevNextButton.h"

#define WIDTH 20.0
#define HEIGHT 20.0

@implementation PrevNextButton

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect iconRect = [self iconRectForBounds:self.bounds];
    CGContextMoveToPoint(ctx, CGRectGetMinX(iconRect), CGRectGetMinY(iconRect));
    CGContextAddLineToPoint(ctx, CGRectGetMinX(iconRect), CGRectGetMaxY(iconRect));
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(iconRect), CGRectGetMidY(iconRect));
    CGContextClosePath(ctx);
    
    CGContextFillPath(ctx);
}


- (CGRect)iconRectForBounds:(CGRect)bounds {
    CGFloat x = round(CGRectGetMidX(bounds) - WIDTH);
    CGFloat y = round(CGRectGetMidY(bounds) - HEIGHT);
    CGFloat w = WIDTH;
    CGFloat h = HEIGHT;
    
    CGRect r = CGRectMake(x, y, w, h);
    return r;
}

@end
