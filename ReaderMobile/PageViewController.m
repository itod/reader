//
//  PageViewController.m
//  ReaderMobile
//
//  Created by Todd Ditchendorf on 3/11/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "PageViewController.h"
#import "Story.h"
#import "PageView.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)dealloc {
    self.pageView = nil;
    self.story = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    TDAssertMainThread();
    TDAssert(self.pageView);
    TDAssert(_story);
    
    [_story reset];
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


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
