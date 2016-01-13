//
//  Phrase.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Phrase.h"

@implementation Phrase

- (void)dealloc {
    self.text = nil;
    self.imageName = nil;
    [super dealloc];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p (%@)[%@]>", [self class], self, _text, _imageName];
}


#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    Phrase *phrase = [[Phrase alloc] init];
    phrase.text = _text;
    phrase.imageName = _imageName;
    
    return phrase;
}


#pragma mark -
#pragma mark Serializable

+ (instancetype)fromPlist:(NSDictionary *)plist {
    Phrase *phrase = [[[Phrase alloc] init] autorelease];
    
    phrase.text = plist[@"text"];
    phrase.imageName = plist[@"imageName"];
    
    return phrase;
}


- (NSMutableDictionary *)asPlist {
    NSMutableDictionary *plist = [NSMutableDictionary dictionary];
    
    if (_text) plist[@"text"] = _text;
    if (_imageName) plist[@"imageName"] = _imageName;
    
    return plist;
}

@end
