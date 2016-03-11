//
//  Story.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Story.h"
#import "Page.h"

@interface Story ()
@property (nonatomic, assign, readwrite) NSInteger pageIndex;
@end

@implementation Story

- (instancetype)init {
    self = [super init];
    if (self) {
        self.pageIndex = -1;
    }
    return self;
}


- (void)dealloc {
    self.pages = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    Story *story = [[Story alloc] init];
    story.pages = _pages;
    
    return story;
}


#pragma mark -
#pragma mark Serializable

+ (instancetype)fromPlist:(NSDictionary *)plist {
    Story *story = [[[Story alloc] init] autorelease];
    
    // pages
    {
        NSMutableArray *pages = [NSMutableArray array];
        for (id pagePlist in plist[@"pages"]) {
            Page *page = [Page fromPlist:pagePlist];
            [pages addObject:page];
        }
        story.pages = pages;
    }

    return story;
}


- (NSMutableDictionary *)asPlist {
    NSMutableDictionary *plist = [NSMutableDictionary dictionary];
    
    // pages
    {
        NSMutableArray *pagePlists = [NSMutableArray array];
        for (Page *page in _pages) {
            id pagePlist = [page asPlist];
            [pagePlists addObject:pagePlist];
        }
        plist[@"pages"] = pagePlists;
    }
    
    
    return plist;
}


#pragma mark -
#pragma mark Public

- (Page *)currentPage {
    TDAssertMainThread();
    TDAssert(_pageIndex > -1);
    TDAssert(_pageIndex < [_pages count]);
    
    return _pages[_pageIndex];
}


- (void)advance:(NSInteger)pages {
    TDAssertMainThread();

    self.pageIndex += pages;
    
    TDAssert(_pageIndex > -1);
    TDAssert(_pageIndex < [_pages count]);
}


- (void)reset {
    self.pageIndex = -1;
}


- (NSMutableString *)text {
    NSMutableString *str = [NSMutableString string];
    
    for (Page *page in _pages) {
        [str appendFormat:@"%@\n", page.text];
    }
    
    return str;
}

@end
