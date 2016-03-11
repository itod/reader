//
//  ViewController.m
//  ReaderMobile
//
//  Created by Todd Ditchendorf on 3/11/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "ViewController.h"
#import "Story.h"
#import "StoryParser.h"
#import "StoryAssembler.h"
#import "PageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
    self.story = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    // load story
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cinderella" ofType:@"story"];
    TDAssert([path length]);
    
    NSError *err = nil;
    NSString *storyText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    
    StoryAssembler *ass = [[[StoryAssembler alloc] init] autorelease];
    StoryParser *parser = [[[StoryParser alloc] initWithDelegate:ass] autorelease];
    
    err = nil;
    Story *story = [parser parseString:storyText error:&err];
    
    self.story = story;

    TDAssertMainThread();
    TDAssert(self.pageView);
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
    self.pageView.page = page;
    [self.pageView setNeedsDisplay];
}


#pragma mark -
#pragma mark Properties

- (PageView *)pageView {
    return (id)self.view;
}

@end
