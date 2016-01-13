#import "StoryParser.h"
#import <PEGKit/PEGKit.h>


@interface StoryParser ()

@end

@implementation StoryParser { }

- (instancetype)initWithDelegate:(id)d {
    self = [super initWithDelegate:d];
    if (self) {
        
        self.startRuleName = @"story";
        self.tokenKindTab[@"]"] = @(STORYPARSER_TOKEN_KIND_CLOSE_BRACKET);
        self.tokenKindTab[@"["] = @(STORYPARSER_TOKEN_KIND_OPEN_BRACKET);
        self.tokenKindTab[@";"] = @(STORYPARSER_TOKEN_KIND_SEMI_COLON);
        self.tokenKindTab[@"}"] = @(STORYPARSER_TOKEN_KIND_CLOSE_CURLY);
        self.tokenKindTab[@"{"] = @(STORYPARSER_TOKEN_KIND_OPEN_CURLY);

        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_CLOSE_BRACKET] = @"]";
        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_OPEN_BRACKET] = @"[";
        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_SEMI_COLON] = @";";
        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_CLOSE_CURLY] = @"}";
        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_OPEN_CURLY] = @"{";

    }
    return self;
}

- (void)dealloc {
    

    [super dealloc];
}

- (void)start {
    [self execute:^{
    
    PKTokenizer *t = self.tokenizer;
    [t.symbolState add:@"!="];
    [t.symbolState add:@"<="];
    [t.symbolState add:@">="];
    
	t.whitespaceState.reportsWhitespaceTokens = YES;
	self.assembly.preservesWhitespaceTokens = YES;

    }];

    [self story_]; 
    [self matchEOF:YES]; 

}

- (void)story_ {
    
    do {
        [self line_]; 
    } while ([self predicts:TOKEN_KIND_BUILTIN_ANY]);

    [self fireDelegateSelector:@selector(parser:didMatchStory:)];
}

- (void)line_ {
    
    do {
        [self phraseSpec_]; 
        [self imageSpec_]; 
    } while ([self predicts:STORYPARSER_TOKEN_KIND_OPEN_CURLY]);
    [self match:STORYPARSER_TOKEN_KIND_SEMI_COLON discard:YES]; 

    [self fireDelegateSelector:@selector(parser:didMatchLine:)];
}

- (void)phraseSpec_ {
    
    [self match:STORYPARSER_TOKEN_KIND_OPEN_CURLY discard:NO]; 
    do {
        if (![self predicts:STORYPARSER_TOKEN_KIND_CLOSE_CURLY, 0]) {
            [self match:TOKEN_KIND_BUILTIN_ANY discard:NO];
        } else {
            [self raise:@"negation test failed in phraseSpec"];
        }
    } while ([self predicts:STORYPARSER_TOKEN_KIND_OPEN_CURLY]);
    [self match:STORYPARSER_TOKEN_KIND_CLOSE_CURLY discard:YES];

    [self fireDelegateSelector:@selector(parser:didMatchPhraseSpec:)];
}

- (void)imageSpec_ {
    
    [self match:STORYPARSER_TOKEN_KIND_OPEN_BRACKET discard:NO]; 
    do {
        if (![self predicts:STORYPARSER_TOKEN_KIND_CLOSE_BRACKET, 0]) {
            [self match:TOKEN_KIND_BUILTIN_ANY discard:NO];
        } else {
            [self raise:@"negation test failed in imageSpec"];
        }
    } while ([self predicts:STORYPARSER_TOKEN_KIND_OPEN_BRACKET]);
    [self match:STORYPARSER_TOKEN_KIND_CLOSE_BRACKET discard:YES];

    [self fireDelegateSelector:@selector(parser:didMatchImageSpec:)];
}

@end