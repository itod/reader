//
//  Run.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Run.h"
#import "Phrase.h"

@implementation Run

- (void)dealloc {
    self.phrases = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    Run *run = [[Run alloc] init];
    
    run.phrases = _phrases;
    
    return run;
}


#pragma mark -
#pragma mark Public

- (NSMutableString *)phraseText {
    NSMutableString *str = [NSMutableString string];
    
    for (Phrase *phrase in _phrases) {
        [str appendFormat:@"%@ ", phrase.text];
    }
    
    return str;
}

@end
