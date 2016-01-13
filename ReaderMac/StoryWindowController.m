//
//  StoryWindowController.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "StoryWindowController.h"

@interface StoryWindowController ()

@end

@implementation StoryWindowController

- (instancetype)init {
    self = [self initWithWindowNibName:NSStringFromClass([self class])];
    return self;
}


- (void)dealloc {
    self.pageView = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark NSWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    TDAssertMainThread();
    TDAssert(_pageView);
}

@end
