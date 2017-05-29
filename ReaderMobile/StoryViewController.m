//
//  StoryViewController.m
//  ReaderMobile
//
//  Created by Todd Ditchendorf on 3/11/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "StoryViewController.h"
#import "Story.h"
#import "PageView.h"
#import "PrevNextButton.h"

@interface StoryViewController ()

@end

@implementation StoryViewController

- (void)dealloc {
    self.pageView = nil;
    self.prevButton = nil;
    self.nextButton = nil;
    self.story = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark UIViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    TDAssertMainThread();
    TDAssert(self.pageView);
    TDAssert(_story);
    
    [self displayPage];
}


#pragma mark -
#pragma mark Actions

- (IBAction)prevPage:(id)sender {
    TDAssertMainThread();
    
    TDAssert(_story);
    [_story reverse:1];
    
    [self displayPage];
}


- (IBAction)nextPage:(id)sender {
    TDAssertMainThread();
    
    TDAssert(_story);
    [_story forward:1];
    
    [self displayPage];
}


- (void)displayPage {
    Page *page = [_story currentPage];
    self.pageView.page = page;
    [self.pageView setNeedsDisplay];

    self.prevButton.enabled = !_story.isFirstPage;
    self.nextButton.enabled = !_story.isLastPage;
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
