//
//  StoryWindowController.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PageRenderer.h"

@class PageView;
@class PageRenderer;
@class Story;

@interface StoryWindowController : NSWindowController <PageRendererDelegate>

- (IBAction)prevPage:(id)sender;
- (IBAction)nextPage:(id)sender;

@property (nonatomic, retain) IBOutlet PageView *pageView;
@property (nonatomic, retain) IBOutlet PageRenderer *pageRenderer;

@property (nonatomic, retain) Story *story;
@end
