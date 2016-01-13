//
//  StoryWindowController.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "StoryWindowController.h"
#import "Story.h"
#import "PageView.h"

@interface StoryWindowController ()

@end

@implementation StoryWindowController

- (instancetype)init {
    self = [self initWithWindowNibName:NSStringFromClass([self class])];
    return self;
}


- (void)dealloc {
    self.pageView = nil;
    self.story = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark NSWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    TDAssertMainThread();
    TDAssert(_pageView);
    TDAssert(_story);

    [self nextPage:nil];
}


#pragma mark -
#pragma mark Actions

- (IBAction)prevPage:(id)sender {
    TDAssertMainThread();
    
    
}


- (IBAction)nextPage:(id)sender {
    TDAssertMainThread();
 
    TDAssert(_story);
    [_story advance:1];
    
    Page *page = [_story currentPage];
    _pageView.page = page;
    [_pageView setNeedsDisplay:YES];
}


#pragma mark -
#pragma mark PageRendererDelegate


@end
