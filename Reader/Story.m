//
//  Story.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Story.h"

@implementation Story

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    Story *story = [[Story alloc] init];
    
    
    return story;
}


#pragma mark -
#pragma mark Serializable

+ (instancetype)fromPlist:(NSDictionary *)plist {
    Story *story = [[[Story alloc] init] autorelease];
    
    
    return story;
}


- (NSMutableDictionary *)asPlist {
    NSMutableDictionary *plist = [NSMutableDictionary dictionary];
    
    
    
    return plist;
}

@end
