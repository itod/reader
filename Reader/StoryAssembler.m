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
#import "NSArray+PEGKitAdditions.h"

@interface StoryAssembler ()
@property (nonatomic, retain) NSMutableArray *pages;
@property (nonatomic, retain) PKToken *openCurly;
@property (nonatomic, retain) PKToken *openSquare;
@end

@implementation StoryAssembler

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.openCurly = [PKToken tokenWithTokenType:PKTokenTypeSymbol stringValue:@"{" doubleValue:0.0];
        self.openSquare = [PKToken tokenWithTokenType:PKTokenTypeSymbol stringValue:@"[" doubleValue:0.0];
    }
    return self;
}


- (void)dealloc {
    self.pages = nil;
    self.openCurly = nil;
    self.openSquare = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark StoryParserDelegate

- (void)parser:(PKParser *)p willMatchStory:(PKAssembly *)a {
    self.pages = [NSMutableArray array];
}


- (void)parser:(PKParser *)p didMatchStory:(PKAssembly *)a {
    Story *story = [[[Story alloc] init] autorelease];
    story.pages = _pages;
    
    TDAssert(a.isStackEmpty);
    a.target = story;
}


- (void)parser:(PKParser *)p didMatchLine:(PKAssembly *)a {
    NSArray *phrases = [[a objectsAbove:nil] reversedArray];
    
    Page *page = [[[Page alloc] init] autorelease];
    page.phrases = phrases;
    
    TDAssert(_pages);
    [_pages addObject:page];
}


- (void)parser:(PKParser *)p didMatchTerminator:(PKAssembly *)a {
    PKToken *tok = [a pop];
    TDAssert([tok.stringValue isEqualToString:@";"]);
    
    Phrase *phrase = [[[Phrase alloc] init] autorelease];
    phrase.text = tok.stringValue;
    
    //[a push:phrase];
}


- (void)parser:(PKParser *)p didMatchText:(PKAssembly *)a {
    PKToken *tok = [a pop];
    TDAssert(![tok.stringValue isEqualToString:@";"]);
    
    Phrase *phrase = [[[Phrase alloc] init] autorelease];
    phrase.text = tok.stringValue;
    
    [a push:phrase];
}


- (void)parser:(PKParser *)p didMatchPhraseSpec:(PKAssembly *)a {
    PKToken *tok = [a pop];
    TDAssert(tok.isDelimitedString);
    
    Phrase *phrase = [[[Phrase alloc] init] autorelease];
    phrase.text = [tok.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
    
    [a push:phrase];
}


- (void)parser:(PKParser *)p didMatchImageSpec:(PKAssembly *)a {
    PKToken *tok = [a pop];
    TDAssert(tok.isDelimitedString);
    
    Phrase *phrase = [a pop];
    TDAssert([phrase isKindOfClass:[Phrase class]]);
    
    phrase.imageName = [tok.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[]"]];
    
    [a push:phrase];
}

@end
