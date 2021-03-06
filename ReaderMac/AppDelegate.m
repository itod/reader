//
//  AppDelegate.m
//  ReaderMac
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "AppDelegate.h"
#import "Story.h"
#import "StoryParser.h"
#import "StoryAssembler.h"
#import "StoryWindowController.h"

@interface AppDelegate ()
@property (nonatomic, retain) StoryWindowController *storyWindowController;
@end

@implementation AppDelegate

- (void)dealloc {
    self.storyWindowController = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.storyWindowController = [[[StoryWindowController alloc] init] autorelease];
    
    // load story
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cinderella" ofType:@"story"];
    TDAssert([path length]);
    
    NSError *err = nil;
    NSString *storyText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    
    StoryAssembler *ass = [[[StoryAssembler alloc] init] autorelease];
    StoryParser *parser = [[[StoryParser alloc] initWithDelegate:ass] autorelease];
    
    err = nil;
    Story *story = [parser parseString:storyText error:&err];
    
    _storyWindowController.story = story;
    
    [_storyWindowController showWindow:nil];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
