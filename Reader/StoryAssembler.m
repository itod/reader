//
//  StoryAssembler.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "StoryAssembler.h"
#import "Story.h"
#import "Page.h"
#import "Phrase.h"

#import <PEGKit/PKAssembly.h>
#import <PEGKit/PKToken.h>

@interface StoryAssembler ()
@property (nonatomic, retain) NSMutableArray *pages;
@property (nonatomic, retain) PKToken *openCurly;
@property (nonatomic, retain) PKToken *openSquare;
@end

@implementation StoryAssembler

- (instancetype)init {
    self = [super init];
    if (self) {
        self.story = nil;
        self.pages = [NSMutableArray array];
        
        self.openCurly = [PKToken tokenWithTokenType:PKTokenTypeSymbol stringValue:@"{" doubleValue:0.0];
        self.openSquare = [PKToken tokenWithTokenType:PKTokenTypeSymbol stringValue:@"[" doubleValue:0.0];
    }
    return self;
}


- (void)dealloc {
    self.story = nil;
    self.pages = nil;
    self.openCurly = nil;
    self.openSquare = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark StoryParserDelegate

- (void)parser:(PKParser *)p didMatchStory:(PKAssembly *)a {
    Story *story = [[[Story alloc] init] autorelease];
    story.pages = _pages;
    
    self.story = story;
}


- (void)parser:(PKParser *)p didMatchLine:(PKAssembly *)a {
    NSArray *phrases = [a objectsAbove:nil];
    
    Page *page = [[[Page alloc] init] autorelease];
    page.phrases = phrases;
    
    TDAssert(_pages);
    [_pages addObject:page];
}


- (void)parser:(PKParser *)p didMatchPhraseSpec:(PKAssembly *)a {
    NSArray *toks = [a objectsAbove:_openCurly];
    [a pop];
    
    NSMutableString *str = [NSMutableString string];
    for (PKToken *tok in [toks reverseObjectEnumerator]) {
        [str appendString:tok.stringValue];
    }
    
    Phrase *phrase = [[[Phrase alloc] init] autorelease];
    phrase.text = str;
    
    [a push:phrase];
}


- (void)parser:(PKParser *)p didMatchImageSpec:(PKAssembly *)a {
    NSArray *toks = [a objectsAbove:_openSquare];
    [a pop];
    
    NSMutableString *str = [NSMutableString string];
    for (PKToken *tok in [toks reverseObjectEnumerator]) {
        [str appendString:tok.stringValue];
    }
    
    Phrase *phrase = [a pop];
    TDAssert([phrase isKindOfClass:[Phrase class]]);
    
    phrase.imageName = str;
    
    [a push:phrase];
}

@end
