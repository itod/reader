//
//  PageRenderer.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Page;

@interface PageRenderer : NSObject

- (void)render:(Page *)page inContext:(CGContextRef)ctx;
@end
