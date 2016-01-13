//
//  PageView.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PageRenderer.h"

@class Page;

@interface PageView : NSView <PageRendererDelegate>

@property (nonatomic, retain) IBOutlet PageRenderer *pageRenderer;
@property (nonatomic, retain) Page *page;
@end
