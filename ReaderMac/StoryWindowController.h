//
//  StoryWindowController.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PageView;
@class Story;

@interface StoryWindowController : NSWindowController

- (IBAction)prevPage:(id)sender;
- (IBAction)nextPage:(id)sender;

@property (nonatomic, retain) IBOutlet PageView *pageView;

@property (nonatomic, retain) Story *story;
@end
