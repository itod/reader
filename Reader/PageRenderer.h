//
//  PageRenderer.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Page;
@class PageRenderer;

@protocol PageRendererDelegate <NSObject>

@end

@interface PageRenderer : NSObject

- (void)render:(Page *)page inContext:(CGContextRef)ctx bounds:(CGRect)bounds;

@property (nonatomic, assign) IBOutlet id <PageRendererDelegate>delegate;
@end
