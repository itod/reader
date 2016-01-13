//
//  StoryWindowController.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PageView;

@interface StoryWindowController : NSWindowController

@property (nonatomic, retain) IBOutlet PageView *pageView;
@end
