//
//  Story.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Story.h"
#import "PAge.h"

@implementation Story

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

@end
